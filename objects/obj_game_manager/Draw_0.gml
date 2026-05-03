draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_score);

var _shake_x = 0;
var _shake_y = 0;
if (screen_shake_amt > 0) {
    _shake_x = random_range(-screen_shake_amt, screen_shake_amt);
    _shake_y = random_range(-screen_shake_amt, screen_shake_amt);
}

draw_sprite_stretched(spr_bg, 0, 0, 0, 800, 800);

if (phase == PHASE_MENU) {
    draw_sprite_stretched(spr_intro_bg, 0, 0, 0, 800, 800);
    draw_set_color(make_color_rgb(160, 10, 10));
    draw_text_transformed(400, 160, "DOOMTIDE", 7, 7, 0);
    draw_set_color(make_color_rgb(200, 60, 60));
    draw_text_transformed(400, 270, "A HORROR POKER ROGUELIKE", 2, 2, 0);
    draw_set_color(make_color_rgb(230, 30, 30));
    draw_text_transformed(400, 370, "Survive 3 Antes x 3 Blinds", 1.6, 1.6, 0);
    draw_set_color(make_color_rgb(200, 80, 80));
    draw_text_transformed(400, 430, "Doom rises every round.  At 10 you DIE.", 1.4, 1.4, 0);
    draw_text_transformed(400, 465, "Doom cards force themselves on you.", 1.4, 1.4, 0);
    draw_text_transformed(400, 500, "INVOKE them for power, EXORCISE them for survival.", 1.4, 1.4, 0);
    draw_text_transformed(400, 535, "Hover doom cards to read their effects.", 1.4, 1.4, 0);
    draw_set_alpha(0.5 + sin(phase_timer * 0.08) * 0.5);
    draw_set_color(c_white);
    draw_text_transformed(400, 620, "CLICK TO BEGIN", 2.2, 2.2, 0);
    draw_set_alpha(1);
    exit;
}

if (phase == PHASE_GAMEOVER) {
    draw_sprite_stretched(spr_gameover_bg, 0, 0, 0, 800, 800);
    draw_set_color(make_color_rgb(120, 0, 0));
    draw_text_transformed(400, 250, "CONSUMED", 7.5, 7.5, 0);
    draw_set_color(make_color_rgb(180, 30, 30));
    draw_text_transformed(400, 390, "The darkness has claimed your soul.", 1.8, 1.8, 0);
    draw_set_color(make_color_rgb(160, 80, 80));
    draw_text_transformed(400, 440, "Ante " + string(ante) + "  |  Blind " + string(blind_idx + 1) + "  |  Doom " + string(doom), 1.4, 1.4, 0);
    draw_set_alpha(0.5 + sin(phase_timer * 0.07) * 0.5);
    draw_set_color(c_white);
    draw_text_transformed(400, 540, "Click to try again", 1.8, 1.8, 0);
    draw_set_alpha(1);
    exit;
}

if (phase == PHASE_WIN) {
    draw_sprite_stretched(spr_win_overlay, 0, 0, 0, 800, 800);
    draw_set_color(make_color_rgb(210, 180, 60));
    draw_text_transformed(400, 230, "SURVIVED", 7, 7, 0);
    draw_set_color(make_color_rgb(220, 220, 180));
    draw_text_transformed(400, 370, "You defied the darkness.", 2.5, 2.5, 0);
    draw_set_color(make_color_rgb(190, 170, 100));
    draw_text_transformed(400, 440, "Final Doom: " + string(doom) + " / 10   |   Gold: $" + string(money), 1.6, 1.6, 0);
    draw_set_alpha(0.5 + sin(phase_timer * 0.07) * 0.5);
    draw_set_color(c_white);
    draw_text_transformed(400, 550, "Click to play again", 1.8, 1.8, 0);
    draw_set_alpha(1);
    exit;
}

if (phase == PHASE_JUMPSCARE) {
    var _t      = jumpscare_timer / JUMPSCARE_DUR;
    var _frame  = clamp(jumpscare_timer div 5, 0, 5);
    draw_sprite_stretched(spr_jumpscare, _frame, _shake_x, _shake_y, 800, 800);
    draw_set_color(c_white);
    var _alpha = 1.0 - _t;
    draw_set_alpha(min(1.0, _alpha * 2));
    draw_text_transformed(400, 700, current_scare_msg, 4.0, 4.0, 0);
    draw_set_alpha(1);
    exit;
}

if (phase == PHASE_SHOP) {
    draw_set_color(make_color_rgb(130, 15, 15));
    draw_text_transformed(400, 50, "CURSED MARKET", 3.2, 3.2, 0);
    draw_set_color(make_color_rgb(255, 230, 80));
    draw_text_transformed(400, 110, "$" + string(money), 2.5, 2.5, 0);
    draw_set_color(make_color_rgb(180, 60, 60));
    draw_text_transformed(400, 150, "Doom  " + string(doom) + " / " + string(MAX_DOOM), 1.8, 1.8, 0);

    for (var _i = 0; _i < 2; _i++) {
        var _bid = shop_offers[_i];
        var _bx  = 200 + _i * 400;
        if (_bid < 0) {
            draw_set_color(make_color_rgb(25, 8, 8));
            draw_rectangle(_bx - 130, 195, _bx + 130, 380, false);
            draw_set_color(make_color_rgb(55, 15, 15));
            draw_rectangle(_bx - 130, 195, _bx + 130, 380, true);
            draw_set_color(make_color_rgb(80, 30, 30));
            draw_text_transformed(_bx, 287, "SOLD", 2, 2, 0);
        } else {
            var _cost = shop_boon_costs[_bid];
            var _hov  = point_in_rectangle(mouse_x, mouse_y, _bx - 130, 195, _bx + 130, 380);
            var _can  = (money >= _cost);
            if (_hov && _can) { draw_set_color(make_color_rgb(80, 12, 12)); }
            else if (_can)    { draw_set_color(make_color_rgb(45, 6, 6)); }
            else              { draw_set_color(make_color_rgb(20, 5, 5)); }
            draw_rectangle(_bx - 130, 195, _bx + 130, 380, false);
            if (_can) { draw_set_color(make_color_rgb(140, 30, 30)); }
            else      { draw_set_color(make_color_rgb(60, 20, 20)); }
            draw_rectangle(_bx - 130, 195, _bx + 130, 380, true);

            if (_can) { draw_set_color(make_color_rgb(255, 220, 80)); }
            else      { draw_set_color(make_color_rgb(120, 70, 30)); }
            draw_text_transformed(_bx, 235, shop_boon_names[_bid], 1.7, 1.7, 0);
            draw_set_color(make_color_rgb(210, 170, 170));
            draw_text_transformed(_bx, 290, shop_boon_descs[_bid], 1.15, 1.15, 0);
            if (_cost == 0) {
                draw_set_color(make_color_rgb(220, 100, 100));
                draw_text_transformed(_bx, 350, "FREE", 1.6, 1.6, 0);
            } else {
                if (_can) { draw_set_color(make_color_rgb(255, 230, 60)); }
                else      { draw_set_color(make_color_rgb(130, 80, 30)); }
                draw_text_transformed(_bx, 350, "$" + string(_cost), 1.7, 1.7, 0);
            }
        }
    }

    draw_set_color(make_color_rgb(200, 50, 50));
    draw_text_transformed(400, 425, "Doom Cards  -  click to Exorcise", 1.5, 1.5, 0);

    var _exorcise_cost = max(doom * 2, 4);
    for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
        var _dx = get_doom_slot_x(_i);
        var _id = doom_slots[_i];
        if (_id < 0) {
            draw_set_color(make_color_rgb(18, 5, 5));
            draw_rectangle(_dx, 450, _dx + DC_W, 580, false);
            draw_set_color(make_color_rgb(40, 12, 12));
            draw_rectangle(_dx, 450, _dx + DC_W, 580, true);
            draw_set_color(make_color_rgb(55, 18, 18));
            draw_text_transformed(_dx + DC_W / 2, 515, "empty", 0.9, 0.9, 0);
        } else {
            var _hov = (hover_shop_slot == _i);
            var _can = (money >= _exorcise_cost);
            if (_hov && _can) { draw_set_color(make_color_rgb(60, 8, 8)); }
            else              { draw_set_color(make_color_rgb(32, 5, 5)); }
            draw_rectangle(_dx, 450, _dx + DC_W, 580, false);
            if (_can) { draw_set_color(make_color_rgb(170, 28, 28)); }
            else      { draw_set_color(make_color_rgb(70, 20, 20)); }
            draw_rectangle(_dx, 450, _dx + DC_W, 580, true);

            draw_sprite_stretched(doom_art[_id], 0, _dx + 8, 462, DC_W - 16, 50);
            draw_set_color(make_color_rgb(230, 60, 60));
            draw_text_transformed(_dx + DC_W / 2, 525, doom_names[_id], 1.0, 1.0, 0);

            draw_set_alpha(0.85);
            draw_set_color(make_color_rgb(90, 8, 8));
            draw_rectangle(_dx + 5, 552, _dx + DC_W - 5, 575, false);
            draw_set_alpha(1);
            if (_can) { draw_set_color(c_white); }
            else      { draw_set_color(make_color_rgb(100, 50, 50)); }
            draw_text_transformed(_dx + DC_W / 2, 564, "$" + string(_exorcise_cost), 1.0, 1.0, 0);
        }
    }

    if (hover_shop_slot >= 0 && doom_slots[hover_shop_slot] >= 0) {
        var _id = doom_slots[hover_shop_slot];
        draw_set_color(c_black);
        draw_set_alpha(0.92);
        draw_rectangle(120, 605, 680, 685, false);
        draw_set_alpha(1);
        draw_set_color(make_color_rgb(180, 30, 30));
        draw_rectangle(120, 605, 680, 685, true);
        draw_set_color(make_color_rgb(230, 80, 80));
        draw_text_transformed(400, 625, doom_passives[_id], 1.0, 1.0, 0);
        draw_set_color(make_color_rgb(180, 130, 220));
        draw_text_transformed(400, 660, doom_channels[_id], 0.95, 0.95, 0);
    }

    var _next_bi = blind_idx + 1;
    var _next_a  = ante;
    if (_next_bi >= 3) { _next_bi = 0; _next_a++; }
    var _next_is_boss = (_next_bi == 2 && _next_a <= MAX_ANTE);

    if (_next_is_boss) {
        var _nbid = _next_a - 1;
        draw_set_color(make_color_rgb(255, 70, 70));
        draw_text_transformed(400, 615, "NEXT: BOSS BLIND", 1.4, 1.4, 0);
        if (boss_sprites[_nbid] >= 0) {
            draw_sprite_stretched(boss_sprites[_nbid], 0, 350, 630, 100, 60);
        }
        draw_set_color(make_color_rgb(255, 100, 100));
        draw_text_transformed(400, 670, blind_names[(_next_a - 1) * 3 + 2], 1.4, 1.4, 0);
        draw_set_color(make_color_rgb(220, 130, 130));
        draw_text_transformed(400, 695, boss_passive_descs[_nbid], 0.95, 0.95, 0);
    } else if (_next_a > MAX_ANTE) {
        draw_set_color(make_color_rgb(255, 230, 100));
        draw_text_transformed(400, 660, "FINAL VICTORY AWAITS", 1.6, 1.6, 0);
    } else {
        draw_set_color(make_color_rgb(180, 80, 80));
        draw_text_transformed(400, 645, "Next:  " + next_blind_label(), 1.3, 1.3, 0);
        draw_set_color(make_color_rgb(160, 90, 90));
        draw_text_transformed(400, 678, "Target Score:  " + string(round(ante_bases[_next_a - 1] * blind_mults[_next_bi])), 1.1, 1.1, 0);
    }

    var _ph = point_in_rectangle(mouse_x, mouse_y, 290, 720, 510, 780);
    if (_ph) { draw_set_color(make_color_rgb(180, 22, 22)); }
    else     { draw_set_color(make_color_rgb(100, 12, 12)); }
    draw_rectangle(290, 720, 510, 780, false);
    draw_set_color(make_color_rgb(210, 60, 60));
    draw_rectangle(290, 720, 510, 780, true);
    draw_set_color(c_white);
    draw_text_transformed(400, 750, "PROCEED", 1.7, 1.7, 0);
    exit;
}

// ============================================================
// MAIN GAME HUD
// ============================================================

var _seg_w  = 32;
var _seg_h  = 22;
var _seg_gp = 3;
var _seg_tot = 10 * _seg_w + 9 * _seg_gp;
var _seg_sx = 400 - _seg_tot / 2;
var _seg_y  = 10;

var _doom_pulse = 0;
if (doom >= 7) _doom_pulse = (sin(phase_timer * 0.18) * 0.5 + 0.5);

draw_set_color(make_color_rgb(160, 25, 25));
draw_text_transformed(_seg_sx - 54, _seg_y + _seg_h / 2, "DOOM", 1.3, 1.3, 0);

for (var _i = 0; _i < 10; _i++) {
    var _sx = _seg_sx + _i * (_seg_w + _seg_gp);
    if (_i < doom) {
        var _iv = 90 + _i * 16;
        if (doom >= 7) _iv = min(255, _iv + round(60 * _doom_pulse));
        draw_set_color(make_color_rgb(min(_iv, 255), 5, 5));
    } else {
        draw_set_color(make_color_rgb(22, 8, 8));
    }
    draw_rectangle(_sx, _seg_y, _sx + _seg_w, _seg_y + _seg_h, false);
    draw_set_color(make_color_rgb(80, 18, 18));
    draw_rectangle(_sx, _seg_y, _sx + _seg_w, _seg_y + _seg_h, true);
}

draw_set_color(make_color_rgb(220, 50, 50));
draw_text_transformed(_seg_sx + _seg_tot + 38, _seg_y + _seg_h / 2,
    string(doom) + "/" + string(MAX_DOOM), 1.25, 1.25, 0);

var _icon_frame = clamp(doom div 3, 0, 3);
draw_sprite(spr_doom_meter_icon, _icon_frame, _seg_sx + _seg_tot + 84, _seg_y + _seg_h / 2);

var _boss_now = is_boss_blind();
if (_boss_now) { draw_set_color(make_color_rgb(255, 80, 80)); }
else           { draw_set_color(make_color_rgb(255, 220, 80)); }
draw_text_transformed(400, 56,
    "Ante " + string(ante) + " / " + string(MAX_ANTE) + "   " + current_blind_name(), 1.55, 1.55, 0);

if (_boss_now) {
    var _bid = current_boss_id();
    var _icon_x = 60;
    var _icon_y = 50;
    var _icon_s = 64;
    var _pulse  = sin(phase_timer * 0.1) * 0.15 + 1.0;
    var _ds     = round(_icon_s * _pulse);
    if (boss_sprites[_bid] >= 0) {
        draw_sprite_stretched(boss_sprites[_bid], 0,
            _icon_x - _ds / 2, _icon_y - _ds / 2, _ds, _ds);
    }
    draw_set_color(make_color_rgb(180, 30, 30));
    draw_rectangle(_icon_x - _ds / 2 - 2, _icon_y - _ds / 2 - 2,
                   _icon_x + _ds / 2 + 2, _icon_y + _ds / 2 + 2, true);
    draw_set_color(make_color_rgb(255, 110, 110));
    draw_text_transformed(_icon_x, _icon_y + _icon_s / 2 + 12, "BOSS", 0.95, 0.95, 0);

    draw_set_color(make_color_rgb(220, 100, 100));
    draw_text_transformed(400, 162, boss_passive_descs[_bid], 1.0, 1.0, 0);
}

var _disp_score = round(display_score);
if (_disp_score < 0) _disp_score = 0;
if (round_score >= target_score) { draw_set_color(make_color_rgb(255, 100, 100)); }
else                             { draw_set_color(make_color_rgb(225, 185, 185)); }
draw_text_transformed(400, 84, string(_disp_score) + "  /  " + string(target_score), 2.4, 2.4, 0);

var _bar_x = 190;
var _bar_y = 108;
var _bar_w = 420;
var _bar_h = 11;
draw_set_color(make_color_rgb(32, 8, 8));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);
var _prog = min(round_score / max(target_score, 1), 1.0);
if (_prog > 0) {
    draw_set_color(make_color_rgb(190, 15, 15));
    draw_rectangle(_bar_x, _bar_y, _bar_x + round(_bar_w * _prog), _bar_y + _bar_h, false);
}
draw_set_color(make_color_rgb(90, 18, 18));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, true);

var _sy = 134;
draw_set_color(make_color_rgb(150, 200, 255));
draw_text_transformed(161, _sy, "Hands: " + string(hands_left), 1.4, 1.4, 0);
draw_set_color(make_color_rgb(255, 190, 130));
draw_text_transformed(401, _sy, "Discards: " + string(discards_left), 1.4, 1.4, 0);
draw_set_color(make_color_rgb(255, 235, 60));
draw_text_transformed(641, _sy, "$" + string(money), 1.4, 1.4, 0);

if (last_hand_type >= 0 && score_anim_timer > 0) {
    draw_set_color(make_color_rgb(255, 210, 55));
    draw_text_transformed(400, 298, hand_type_name(last_hand_type), 2.0, 2.0, 0);
    var _formula = string(last_chips) + " Chips  x  " + string(last_mult) + " Mult  =  +" + string(last_score);
    draw_set_color(make_color_rgb(220, 175, 175));
    draw_text_transformed(400, 330, _formula, 1.5, 1.5, 0);
}

var _notice_y = 365;
if (frozen_card_rank >= 0 && doom_active(2)) {
    draw_set_color(make_color_rgb(120, 160, 255));
    draw_text_transformed(400, _notice_y,
        "FROZEN: " + rank_display(frozen_card_rank) + " of " + suit_display(frozen_card_suit), 1.15, 1.15, 0);
    _notice_y += 22;
}
if (forgotten_hand >= 0 && doom_active(12) && !doom_channeled_id(12)) {
    draw_set_color(make_color_rgb(180, 80, 80));
    draw_text_transformed(400, _notice_y, "FORGOTTEN: " + hand_type_name(forgotten_hand), 1.15, 1.15, 0);
    _notice_y += 22;
}
if (sacrifice_rank >= 0 && doom_active(6)) {
    draw_set_color(make_color_rgb(220, 70, 70));
    draw_text_transformed(400, _notice_y,
        "SACRIFICED: " + rank_display(sacrifice_rank) + " of " + suit_display(sacrifice_suit), 1.15, 1.15, 0);
}

if (phase == PHASE_PLAY) {
    var _sel_n = count_selected();
    if (_sel_n > 0) {
        draw_set_color(make_color_rgb(220, 110, 110));
        draw_text_transformed(400, 420, string(_sel_n) + " card(s) selected", 1.3, 1.3, 0);
    }
}

// ============================================================
// DOOM CARDS - simplified large UI
// ============================================================
var _dlbl_y = DOOM_Y - DC_H / 2 - 16;
draw_set_color(make_color_rgb(180, 40, 40));
draw_text_transformed(400, _dlbl_y, "DOOM CARDS  -  hover to inspect", 1.2, 1.2, 0);

for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
    var _dx  = get_doom_slot_x(_i);
    var _dy  = DOOM_Y - DC_H / 2;
    var _id  = doom_slots[_i];
    var _ctr_x = _dx + DC_W / 2;
    var _hov   = (hover_doom_slot == _i);

    if (_id < 0) {
        draw_set_color(make_color_rgb(18, 4, 4));
        draw_rectangle(_dx, _dy, _dx + DC_W, _dy + DC_H, false);
        draw_set_color(make_color_rgb(48, 14, 14));
        draw_rectangle(_dx, _dy, _dx + DC_W, _dy + DC_H, true);
        draw_set_color(make_color_rgb(60, 18, 18));
        draw_text_transformed(_ctr_x, _dy + DC_H / 2, "empty", 0.9, 0.9, 0);
    } else {
        if (doom_channeled[_i])      { draw_set_color(make_color_rgb(18, 6, 36)); }
        else if (_hov)               { draw_set_color(make_color_rgb(50, 8, 8)); }
        else                         { draw_set_color(make_color_rgb(32, 4, 4)); }
        draw_rectangle(_dx, _dy, _dx + DC_W, _dy + DC_H, false);

        if (doom_channeled[_i]) { draw_set_color(make_color_rgb(110, 35, 200)); }
        else if (_hov)          { draw_set_color(make_color_rgb(220, 50, 50)); }
        else                    { draw_set_color(make_color_rgb(140, 22, 22)); }
        draw_rectangle(_dx, _dy, _dx + DC_W, _dy + DC_H, true);

        draw_sprite_stretched(doom_art[_id], 0, _dx + 8, _dy + 10, DC_W - 16, 60);

        if (doom_channeled[_i]) { draw_set_color(make_color_rgb(170, 110, 235)); }
        else                    { draw_set_color(make_color_rgb(240, 70, 70)); }
        draw_text_transformed(_ctr_x, _dy + 84, doom_names[_id], 1.0, 1.0, 0);

        if (doom_channeled[_i]) {
            var _ff = (phase_timer mod 4);
            draw_sprite_stretched(spr_invoke_flash, _ff, _dx, _dy, DC_W, DC_H);
        }

        var _btn_top = _dy + DC_H - 30;
        var _btn_bot = _dy + DC_H - 6;
        if (!doom_channeled[_i] && !doom_inhibited[_i] && doom < MAX_DOOM - 1) {
            var _btn_hov = point_in_rectangle(mouse_x, mouse_y, _dx + 8, _btn_top, _dx + DC_W - 8, _btn_bot);
            if (_btn_hov) { draw_set_color(make_color_rgb(220, 28, 28)); }
            else          { draw_set_color(make_color_rgb(120, 14, 14)); }
            draw_rectangle(_dx + 8, _btn_top, _dx + DC_W - 8, _btn_bot, false);
            draw_set_color(c_white);
            draw_text_transformed(_ctr_x, (_btn_top + _btn_bot) / 2, "INVOKE  +2", 0.85, 0.85, 0);
        } else if (doom_channeled[_i]) {
            draw_set_color(make_color_rgb(70, 35, 130));
            draw_rectangle(_dx + 8, _btn_top, _dx + DC_W - 8, _btn_bot, false);
            draw_set_color(make_color_rgb(160, 110, 220));
            draw_text_transformed(_ctr_x, (_btn_top + _btn_bot) / 2, "INVOKED", 0.85, 0.85, 0);
        } else {
            draw_set_color(make_color_rgb(40, 10, 10));
            draw_rectangle(_dx + 8, _btn_top, _dx + DC_W - 8, _btn_bot, false);
            draw_set_color(make_color_rgb(90, 40, 40));
            draw_text_transformed(_ctr_x, (_btn_top + _btn_bot) / 2, "LOCKED", 0.85, 0.85, 0);
        }
    }
}

if (hover_doom_slot >= 0 && doom_slots[hover_doom_slot] >= 0) {
    var _id   = doom_slots[hover_doom_slot];
    var _tx1  = 60;
    var _tx2  = 740;
    var _ty1  = 195;
    var _ty2  = 295;
    draw_set_color(c_black);
    draw_set_alpha(0.94);
    draw_rectangle(_tx1, _ty1, _tx2, _ty2, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(220, 40, 40));
    draw_rectangle(_tx1, _ty1, _tx2, _ty2, true);
    draw_rectangle(_tx1+1, _ty1+1, _tx2-1, _ty2-1, true);
    draw_set_color(make_color_rgb(255, 100, 100));
    draw_text_transformed(400, _ty1 + 16, doom_names[_id], 1.5, 1.5, 0);
    draw_set_color(make_color_rgb(230, 140, 140));
    draw_text_transformed(400, _ty1 + 50, "PASSIVE: " + doom_passives[_id], 1.05, 1.05, 0);
    draw_set_color(make_color_rgb(180, 130, 230));
    draw_text_transformed(400, _ty1 + 80, "INVOKE: " + doom_channels[_id], 1.05, 1.05, 0);
}

// ============================================================
// ACTION BUTTONS
// ============================================================
var _can_play = (phase == PHASE_PLAY) && (count_selected() > 0);
var _can_disc = (phase == PHASE_PLAY) && (count_selected() > 0) && (discards_left > 0);

var _b1h = point_in_rectangle(mouse_x, mouse_y, 60, BTN_Y, 258, BTN_Y + BTN_H);
if (_can_play && _b1h) { draw_set_color(make_color_rgb(210, 32, 32)); }
else if (_can_play)    { draw_set_color(make_color_rgb(135, 15, 15)); }
else                   { draw_set_color(make_color_rgb(42, 10, 10)); }
draw_rectangle(60, BTN_Y, 258, BTN_Y + BTN_H, false);
draw_set_color(c_white);
draw_rectangle(60, BTN_Y, 258, BTN_Y + BTN_H, true);
if (_can_play) { draw_set_color(c_white); }
else           { draw_set_color(make_color_rgb(70, 28, 28)); }
draw_text_transformed(159, BTN_Y + BTN_H / 2, "Play Hand", 1.5, 1.5, 0);

var _b2h = point_in_rectangle(mouse_x, mouse_y, 298, BTN_Y, 502, BTN_Y + BTN_H);
if (_can_disc && _b2h) { draw_set_color(make_color_rgb(148, 15, 15)); }
else if (_can_disc)    { draw_set_color(make_color_rgb(80, 8, 8)); }
else                   { draw_set_color(make_color_rgb(28, 5, 5)); }
draw_rectangle(298, BTN_Y, 502, BTN_Y + BTN_H, false);
draw_set_color(c_white);
draw_rectangle(298, BTN_Y, 502, BTN_Y + BTN_H, true);
if (_can_disc) { draw_set_color(c_white); }
else           { draw_set_color(make_color_rgb(70, 28, 28)); }
draw_text_transformed(400, BTN_Y + BTN_H / 2, "Discard (" + string(discards_left) + ")", 1.5, 1.5, 0);

var _b3h = point_in_rectangle(mouse_x, mouse_y, 542, BTN_Y, 740, BTN_Y + BTN_H);
if (_b3h) { draw_set_color(make_color_rgb(80, 10, 10)); }
else      { draw_set_color(make_color_rgb(40, 5, 5)); }
draw_rectangle(542, BTN_Y, 740, BTN_Y + BTN_H, false);
draw_set_color(c_white);
draw_rectangle(542, BTN_Y, 740, BTN_Y + BTN_H, true);
draw_set_color(c_white);
var _slabel = "Sort: Rank";
if (sort_mode != 0) _slabel = "Sort: Suit";
draw_text_transformed(641, BTN_Y + BTN_H / 2, _slabel, 1.5, 1.5, 0);

// ============================================================
// HIGH-DOOM RED VIGNETTE OVERLAY
// ============================================================
if (doom >= 5) {
    var _intensity = 0;
    if (doom == 5)       _intensity = 0.10;
    else if (doom == 6)  _intensity = 0.15;
    else if (doom == 7)  _intensity = 0.22 + _doom_pulse * 0.08;
    else if (doom == 8)  _intensity = 0.32 + _doom_pulse * 0.12;
    else                 _intensity = 0.42 + _doom_pulse * 0.18;
    draw_set_color(make_color_rgb(160, 0, 0));
    draw_set_alpha(_intensity);
    draw_rectangle(0, 0, 800, 80, false);
    draw_rectangle(0, 720, 800, 800, false);
    draw_rectangle(0, 0, 80, 800, false);
    draw_rectangle(720, 0, 800, 800, false);
    draw_set_alpha(1);
}

// ============================================================
// ROUND WIN / LOSE OVERLAY
// ============================================================
if (phase == PHASE_ROUND_WIN || phase == PHASE_ROUND_LOSE) {
    draw_set_color(c_black);
    draw_set_alpha(0.78);
    draw_rectangle(120, 280, 680, 510, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(150, 20, 20));
    draw_rectangle(120, 280, 680, 510, true);
    if (phase == PHASE_ROUND_WIN) {
        draw_set_color(make_color_rgb(220, 55, 55));
        draw_text_transformed(400, 345, "YOU SURVIVED", 2.6, 2.6, 0);
    } else {
        draw_set_color(make_color_rgb(100, 8, 8));
        draw_text_transformed(400, 345, "CONSUMED BY DARKNESS", 2.0, 2.0, 0);
    }
    draw_set_color(make_color_rgb(220, 165, 165));
    draw_text_transformed(400, 420, result_msg, 1.4, 1.4, 0);
    draw_set_alpha(0.5 + sin(phase_timer * 0.12) * 0.5);
    draw_set_color(c_white);
    draw_text_transformed(400, 470, "Click to continue...", 1.2, 1.2, 0);
    draw_set_alpha(1);
}
