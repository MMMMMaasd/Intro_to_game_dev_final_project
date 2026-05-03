phase_timer++;

if (phase == PHASE_GAMEOVER || phase == PHASE_WIN) {
    if (mouse_check_button_pressed(mb_left)) {
        full_reset();
        phase       = PHASE_MENU;
        phase_timer = 0;
    }
    exit;
}

switch (phase) {

case PHASE_MENU:
    if (mouse_check_button_pressed(mb_left)) {
        full_reset();
        init_round();
        phase       = PHASE_PLAY;
        phase_timer = 0;
    }
    break;

case PHASE_PLAY:
    if (doom >= MAX_DOOM) {
        phase       = PHASE_GAMEOVER;
        phase_timer = 0;
        break;
    }

    if (mouse_check_button_pressed(mb_left)) {
        var _mx = mouse_x;
        var _my = mouse_y;

        for (var _i = 0; _i < MAX_HAND; _i++) {
            var _c = hand_cards[_i];
            if (!instance_exists(_c)) continue;
            var _rise = _c.hover_rise;
            var _cx1  = _c.x - CARD_W / 2;
            var _cy1  = _c.y - CARD_H / 2 - _rise;
            var _cx2  = _c.x + CARD_W / 2;
            var _cy2  = _c.y + CARD_H / 2 - _rise;
            if (point_in_rectangle(_mx, _my, _cx1, _cy1, _cx2, _cy2)) {
                if (_c.selected) { _c.selected = false; }
                else if (count_selected() < MAX_PLAY) { _c.selected = true; }
                break;
            }
        }

        for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
            if (doom_slots[_i] < 0 || doom_channeled[_i] || doom_inhibited[_i]) continue;
            var _dx  = get_doom_slot_x(_i);
            var _dy  = DOOM_Y - DC_H / 2;
            if (point_in_rectangle(_mx, _my, _dx + 8, _dy + DC_H - 28, _dx + DC_W - 8, _dy + DC_H - 6)) {
                channel_doom_card(_i);
                break;
            }
        }

        if (point_in_rectangle(_mx, _my, 60, BTN_Y, 258, BTN_Y + BTN_H)) {
            if (count_selected() > 0) play_hand();
        }
        if (point_in_rectangle(_mx, _my, 298, BTN_Y, 502, BTN_Y + BTN_H)) {
            if (discards_left > 0 && count_selected() > 0) {
                audio_play_sound(snd_card, 1, false);
                discard_selected();
            }
        }
        if (point_in_rectangle(_mx, _my, 542, BTN_Y, 740, BTN_Y + BTN_H)) {
            if (sort_mode == 0) { sort_mode = 1; } else { sort_mode = 0; }
            sort_hand();
        }
    }
    break;

case PHASE_SCORING:
    score_anim_timer++;
    display_score = lerp(display_score, round_score, 0.07);

    if (score_anim_timer >= 110) {
        display_score = round_score;

        if (doom >= MAX_DOOM) {
            phase       = PHASE_GAMEOVER;
            phase_timer = 0;
            break;
        }

        if (doom_active(9) && doom >= 8) {
            phase       = PHASE_GAMEOVER;
            phase_timer = 0;
            break;
        }

        if (round_score >= target_score) {
            var _earn = 4 + hands_left + discards_left;
            money     += _earn;
            result_msg = "You Survived!   +$" + string(_earn);
            if (!doom_active(13)) add_doom(-1);
            clear_play_area();

            if (random(1.0) < jumpscare_chance) {
                post_scare_phase  = PHASE_ROUND_WIN;
                current_scare_msg = scare_msgs[irandom(7)];
                phase             = PHASE_JUMPSCARE;
                phase_timer       = 0;
                jumpscare_timer   = 0;
            } else {
                audio_play_sound(snd_win, 1, false);
                phase       = PHASE_ROUND_WIN;
                phase_timer = 0;
            }
        } else if (hands_left <= 0) {
            result_msg = "The Darkness Claims You...";
            clear_play_area();

            if (random(1.0) < jumpscare_chance) {
                post_scare_phase  = PHASE_ROUND_LOSE;
                current_scare_msg = scare_msgs[irandom(7)];
                phase             = PHASE_JUMPSCARE;
                phase_timer       = 0;
                jumpscare_timer   = 0;
            } else {
                audio_play_sound(snd_lose, 1, false);
                phase       = PHASE_ROUND_LOSE;
                phase_timer = 0;
            }
        } else {
            apply_ghost_hand_passive();
            compact_hand();
            clear_play_area();
            deal_to_hand();

            if (random(1.0) < jumpscare_chance) {
                post_scare_phase  = PHASE_PLAY;
                current_scare_msg = scare_msgs[irandom(7)];
                phase             = PHASE_JUMPSCARE;
                phase_timer       = 0;
                jumpscare_timer   = 0;
            } else {
                phase       = PHASE_PLAY;
                phase_timer = 0;
            }
        }
    }
    break;

case PHASE_JUMPSCARE:
    jumpscare_timer++;
    if (jumpscare_timer >= 65) {
        if (jumpscare_protect) {
            last_mult  += 20;
            last_score  = last_chips * last_mult;
            jumpscare_protect = false;
        } else {
            add_doom(2);
        }

        if (doom >= MAX_DOOM || (doom_active(9) && doom >= 8)) {
            phase       = PHASE_GAMEOVER;
            phase_timer = 0;
            break;
        }

        if (post_scare_phase == PHASE_ROUND_WIN) {
            audio_play_sound(snd_win, 1, false);
            phase       = PHASE_ROUND_WIN;
            phase_timer = 0;
        } else if (post_scare_phase == PHASE_ROUND_LOSE) {
            audio_play_sound(snd_lose, 1, false);
            phase       = PHASE_ROUND_LOSE;
            phase_timer = 0;
        } else {
            phase       = post_scare_phase;
            phase_timer = 0;
        }
    }
    break;

case PHASE_ROUND_WIN:
    if (phase_timer > 90 || mouse_check_button_pressed(mb_left)) {
        with (obj_card) instance_destroy();
        for (var _i = 0; _i < MAX_HAND; _i++) hand_cards[_i] = noone;
        for (var _i = 0; _i < MAX_PLAY; _i++) play_cards[_i] = noone;
        hand_count = 0;
        play_count = 0;
        setup_shop();
        phase       = PHASE_SHOP;
        phase_timer = 0;
    }
    break;

case PHASE_ROUND_LOSE:
    if (phase_timer > 90 || mouse_check_button_pressed(mb_left)) {
        phase       = PHASE_GAMEOVER;
        phase_timer = 0;
    }
    break;

case PHASE_SHOP:
    if (mouse_check_button_pressed(mb_left)) {
        var _mx = mouse_x;
        var _my = mouse_y;

        for (var _i = 0; _i < 2; _i++) {
            var _bid = shop_offers[_i];
            if (_bid < 0) continue;
            var _bx   = 200 + _i * 400;
            var _cost = shop_boon_costs[_bid];
            if (point_in_rectangle(_mx, _my, _bx - 120, 190, _bx + 120, 380)) {
                if (money >= _cost) {
                    money -= _cost;
                    if (_bid == 0) { add_doom(-2); }
                    else if (_bid == 1) { extra_hands++; }
                    else if (_bid == 2) { extra_discards += 2; }
                    else if (_bid == 3) { add_doom_card(); add_doom(1); }
                    shop_offers[_i] = -1;
                    audio_play_sound(snd_bet, 1, false);
                }
            }
        }

        for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
            if (doom_slots[_i] < 0) continue;
            var _dx   = get_doom_slot_x(_i);
            var _cost = max(doom * 5, 5);
            if (point_in_rectangle(_mx, _my, _dx, 450, _dx + DC_W, 560)) {
                if (money >= _cost) {
                    money            -= _cost;
                    doom_slots[_i]    = -1;
                    doom_channeled[_i] = false;
                    doom_inhibited[_i] = false;
                    doom_count--;
                    audio_play_sound(snd_bet, 1, false);
                }
            }
        }

        if (point_in_rectangle(_mx, _my, 300, 590, 500, 650)) {
            blind_idx++;
            if (blind_idx >= 3) {
                blind_idx = 0;
                ante++;
                if (ante > MAX_ANTE) {
                    phase       = PHASE_WIN;
                    phase_timer = 0;
                } else {
                    init_round();
                    phase       = PHASE_PLAY;
                    phase_timer = 0;
                }
            } else {
                init_round();
                phase       = PHASE_PLAY;
                phase_timer = 0;
            }
        }
    }
    break;

}
