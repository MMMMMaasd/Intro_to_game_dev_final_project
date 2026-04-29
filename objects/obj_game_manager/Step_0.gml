phase_timer++;

switch (phase) {

case PHASE_MENU:
    if (mouse_check_button_pressed(mb_left)) {
        ante              = 1;
        blind_idx         = 0;
        money             = 4;
        owned_jokers      = array_create(MAX_JOKERS, -1);
        owned_joker_count = 0;
        init_round();
        phase       = PHASE_PLAY;
        phase_timer = 0;
    }
    break;

case PHASE_PLAY:
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
                if (_c.selected) {
                    _c.selected = false;
                } else if (count_selected() < MAX_PLAY) {
                    _c.selected = true;
                }
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
            if (sort_mode == 0) {
                sort_mode = 1;
            } else {
                sort_mode = 0;
            }
            sort_hand();
        }
    }
    break;

case PHASE_SCORING:
    score_anim_timer++;
    display_score = lerp(display_score, round_score, 0.07);

    if (score_anim_timer >= 110) {
        display_score = round_score;

        if (round_score >= target_score) {
            clear_play_area();
            var _earn = 4 + hands_left + discards_left;
            money    += _earn;
            result_msg = "Round Won!  +$" + string(_earn);
            phase      = PHASE_ROUND_WIN;
            phase_timer = 0;
            audio_play_sound(snd_win, 1, false);
        } else if (hands_left <= 0) {
            clear_play_area();
            result_msg  = "Round Lost!";
            phase       = PHASE_ROUND_LOSE;
            phase_timer = 0;
            audio_play_sound(snd_lose, 1, false);
        } else {
            clear_play_area();
            deal_to_hand();
            phase       = PHASE_PLAY;
            phase_timer = 0;
        }
    }
    break;

case PHASE_ROUND_WIN:
    if (phase_timer > 80 || mouse_check_button_pressed(mb_left)) {
        setup_shop();
        phase       = PHASE_SHOP;
        phase_timer = 0;
    }
    break;

case PHASE_ROUND_LOSE:
    if (phase_timer > 80 || mouse_check_button_pressed(mb_left)) {
        phase       = PHASE_GAMEOVER;
        phase_timer = 0;
    }
    break;

case PHASE_SHOP:
    if (mouse_check_button_pressed(mb_left)) {
        var _mx = mouse_x;
        var _my = mouse_y;

        if (shop_offers[0] >= 0) {
            if (point_in_rectangle(_mx, _my, 110, 220, 310, 490)) {
                if (money >= shop_prices[0] && owned_joker_count < MAX_JOKERS) {
                    money -= shop_prices[0];
                    for (var _i = 0; _i < MAX_JOKERS; _i++) {
                        if (owned_jokers[_i] < 0) {
                            owned_jokers[_i] = shop_offers[0];
                            owned_joker_count++;
                            break;
                        }
                    }
                    shop_offers[0] = -1;
                    audio_play_sound(snd_bet, 1, false);
                }
            }
        }

        if (shop_offers[1] >= 0) {
            if (point_in_rectangle(_mx, _my, 490, 220, 690, 490)) {
                if (money >= shop_prices[1] && owned_joker_count < MAX_JOKERS) {
                    money -= shop_prices[1];
                    for (var _i = 0; _i < MAX_JOKERS; _i++) {
                        if (owned_jokers[_i] < 0) {
                            owned_jokers[_i] = shop_offers[1];
                            owned_joker_count++;
                            break;
                        }
                    }
                    shop_offers[1] = -1;
                    audio_play_sound(snd_bet, 1, false);
                }
            }
        }

        if (point_in_rectangle(_mx, _my, 300, 630, 500, 700)) {
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

case PHASE_GAMEOVER:
    if (mouse_check_button_pressed(mb_left)) {
        ante              = 1;
        blind_idx         = 0;
        money             = 4;
        owned_jokers      = array_create(MAX_JOKERS, -1);
        owned_joker_count = 0;
        phase             = PHASE_MENU;
        phase_timer       = 0;
    }
    break;

case PHASE_WIN:
    if (mouse_check_button_pressed(mb_left)) {
        ante              = 1;
        blind_idx         = 0;
        money             = 4;
        owned_jokers      = array_create(MAX_JOKERS, -1);
        owned_joker_count = 0;
        phase             = PHASE_MENU;
        phase_timer       = 0;
    }
    break;

}
