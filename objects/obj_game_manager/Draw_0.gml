draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_score);

draw_set_color(make_color_rgb(6, 0, 0));
draw_rectangle(0, 0, 800, 800, false);
draw_set_color(make_color_rgb(20, 3, 3));
draw_ellipse(20, 20, 780, 780, false);
draw_set_color(make_color_rgb(90, 8, 8));
draw_ellipse(25, 25, 775, 775, true);
draw_set_color(make_color_rgb(45, 0, 0));
draw_ellipse(55, 55, 745, 745, true);

// ============================================================
// MENU
// ============================================================
if (phase == PHASE_MENU) {
    draw_set_color(make_color_rgb(160, 10, 10));
    draw_text_transformed(400, 160, "DOOMTIDE", 7, 7, 0);
    draw_set_color(make_color_rgb(200, 60, 60));
    draw_text_transformed(400, 270, "A HORROR POKER ROGUELIKE", 2, 2, 0);
    draw_set_color(make_color_rgb(230, 30, 30));
    draw_text_transformed(400, 370, "Survive 3 Antes x 3 Blinds", 1.6, 1.6, 0);
    draw_set_color(make_color_rgb(200, 80, 80));
    draw_text_transformed(400, 430, "Accumulate Doom Cards every round", 1.4, 1.4, 0);
    draw_text_transformed(400, 465, "Doom meter fills 0-10  --  reach 10 = DEATH", 1.4, 1.4, 0);
    draw_text_transformed(400, 500, "INVOKE doom cards for power at great cost", 1.4, 1.4, 0);
    draw_text_transformed(400, 535, "EXORCISE doom cards in the shop to survive", 1.4, 1.4, 0);
    draw_set_alpha(0.5 + sin(phase_timer * 0.08) * 0.5);
    draw_set_color(c_white);
    draw_text_transformed(400, 620, "CLICK TO BEGIN", 2.2, 2.2, 0);
    draw_set_alpha(1);
    exit;
}

// ============================================================
// GAME OVER
// ============================================================
if (phase == PHASE_GAMEOVER) {
    draw_set_color(make_color_rgb(120, 0, 0));
    draw_text_transformed(400, 250, "CONSUMED", 7.5, 7.5, 0);
    draw_set_color(make_color_rgb(180, 30, 30));
    draw_text_transformed(400, 390, "The darkness has claimed your soul.", 1.8, 1.8, 0);
    draw_set_color(make_color_rgb(160, 80, 80));
    draw_text_transformed(400, 440, "Ante " + string(ante) + "  |  Blind " + string(blind_idx + 1) + "  |  Doom was " + string(doom), 1.4, 1.4, 0);
    draw_set_alpha(0.5 + sin(phase_timer * 0.07) * 0.5);
    draw_set_color(c_white);
    draw_text_transformed(400, 540, "Click to try again", 1.8, 1.8, 0);
    draw_set_alpha(1);
    exit;
}

// ============================================================
// WIN
// ============================================================
if (phase == PHASE_WIN) {
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

// ============================================================
// JUMP SCARE
// ============================================================
if (phase == PHASE_JUMPSCARE) {
    var _flash = 1.0 - (jumpscare_timer / 65.0);
    var _ri    = min(255, round(80 + 175 * _flash));
    draw_set_color(make_color_rgb(_ri, 0, 0));
    draw_rectangle(0, 0, 800, 800, false);
    draw_set_color(c_white);
    draw_set_alpha(min(1.0, _flash * 2.5));
    draw_text_transformed(400, 400, current_scare_msg, 5.5 + _flash * 2, 5.5 + _flash * 2, 0);
    draw_set_alpha(1);
    exit;
}

// ============================================================
// SHOP
// ============================================================
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
            draw_rectangle(_bx - 120, 190, _bx + 120, 380, false);
            draw_set_color(make_color_rgb(55, 15, 15));
            draw_rectangle(_bx - 120, 190, _bx + 120, 380, true);
            draw_set_color(make_color_rgb(80, 30, 30));
            draw_text_transformed(_bx, 285, "SOLD", 2, 2, 0);
        } else {
            var _cost = shop_boon_costs[_bid];
            var _hov  = point_in_rectangle(mouse_x, mouse_y, _bx - 120, 190, _bx + 120, 380);
            var _can  = (money >= _cost);
            if (_hov && _can) { draw_set_color(make_color_rgb(70, 10, 10)); }
            else if (_can)    { draw_set_color(make_color_rgb(40, 5, 5)); }
            else              { draw_set_color(make_color_rgb(20, 5, 5)); }
            draw_rectangle(_bx - 120, 190, _bx + 120, 380, false);
            if (_can) { draw_set_color(make_color_rgb(140, 30, 30)); }
            else      { draw_set_color(make_color_rgb(60, 20, 20)); }
            draw_rectangle(_bx - 120, 190, _bx + 120, 380, true);

            if (_can) { draw_set_color(make_color_rgb(255, 220, 80)); }
            else      { draw_set_color(make_color_rgb(120, 70, 30)); }
            draw_text_transformed(_bx, 230, shop_boon_names[_bid], 1.6, 1.6, 0);
            draw_set_color(make_color_rgb(190, 140, 140));
            draw_text_transformed(_bx, 280, shop_boon_descs[_bid], 1.1, 1.1, 0);
            if (_cost == 0) {
                draw_set_color(make_color_rgb(220, 100, 100));
                draw_text_transformed(_bx, 345, "FREE", 1.5, 1.5, 0);
            } else {
                if (_can) { draw_set_color(make_color_rgb(255, 230, 60)); }
                else      { draw_set_color(make_color_rgb(130, 80, 30)); }
                draw_text_transformed(_bx, 345, "$" + string(_cost), 1.6, 1.6, 0);
            }
        }
    }

    draw_set_color(make_color_rgb(200, 50, 50));
    draw_text_transformed(400, 420, "DOOM CARDS  —  click to Exorcise", 1.5, 1.5, 0);

    var _exorcise_cost = max(doom * 5, 5);
    for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
        var _dx = get_doom_slot_x(_i);
        var _id = doom_slots[_i];
        if (_id < 0) {
            draw_set_color(make_color_rgb(18, 5, 5));
            draw_rectangle(_dx, 450, _dx + DC_W, 560, false);
            draw_set_color(make_color_rgb(40, 12, 12));
            draw_rectangle(_dx, 450, _dx + DC_W, 560, true);
            draw_set_color(make_color_rgb(55, 18, 18));
            draw_text_transformed(_dx + DC_W / 2, 505, "empty", 0.9, 0.9, 0);
        } else {
            var _hov  = point_in_rectangle(mouse_x, mouse_y, _dx, 450, _dx + DC_W, 560);
            var _can  = (money >= _exorcise_cost);
            if (_hov && _can) { draw_set_color(make_color_rgb(50, 5, 5)); }
            else              { draw_set_color(make_color_rgb(30, 5, 5)); }
            draw_rectangle(_dx, 450, _dx + DC_W, 560, false);
            if (_can) { draw_set_color(make_color_rgb(160, 25, 25)); }
            else      { draw_set_color(make_color_rgb(70, 20, 20)); }
            draw_rectangle(_dx, 450, _dx + DC_W, 560, true);

            draw_set_color(make_color_rgb(230, 60, 60));
            draw_text_transformed(_dx + DC_W / 2, 468, doom_names[_id], 0.95, 0.95, 0);
            draw_set_color(make_color_rgb(170, 110, 110));
            draw_text_transformed(_dx + DC_W / 2, 498, doom_passives[_id], 0.6, 0.6, 0);
            draw_set_alpha(0.85);
            draw_set_color(make_color_rgb(90, 8, 8));
            draw_rectangle(_dx + 5, 530, _dx + DC_W - 5, 555, false);
            draw_set_alpha(1);
            if (_can) { draw_set_color(c_white); }
            else      { draw_set_color(make_color_rgb(100, 50, 50)); }
            draw_text_transformed(_dx + DC_W / 2, 542, "$" + string(_exorcise_cost), 0.9, 0.9, 0);
        }
    }

    var _ph = point_in_rectangle(mouse_x, mouse_y, 300, 590, 500, 650);
    if (_ph) { draw_set_color(make_color_rgb(160, 20, 20)); }
    else     { draw_set_color(make_color_rgb(90, 10, 10)); }
    draw_rectangle(300, 590, 500, 650, false);
    draw_set_color(make_color_rgb(200, 50, 50));
    draw_rectangle(300, 590, 500, 650, true);
    draw_set_color(c_white);
    draw_text_transformed(400, 620, "PROCEED", 1.8, 1.8, 0);

    draw_set_color(make_color_rgb(180, 50, 50));
    draw_text_transformed(400, 700, "Next:  Ante " + string(ante) + "  Blind " + string(blind_idx + 2), 1.4, 1.4, 0);
    draw_text_transformed(400, 730, "Target Score:  " + string(get_target()), 1.4, 1.4, 0);
    exit;
}

// ============================================================
// MAIN GAME HUD
// ============================================================

// Doom meter segments
var _seg_w  = 32;
var _seg_h  = 20;
var _seg_gp = 3;
var _seg_tot = 10 * _seg_w + 9 * _seg_gp;
var _seg_sx = 400 - _seg_tot / 2;
var _seg_y  = 10;

draw_set_color(make_color_rgb(160, 25, 25));
draw_text_transformed(_seg_sx - 54, _seg_y + _seg_h / 2, "DOOM", 1.2, 1.2, 0);

for (var _i = 0; _i < 10; _i++) {
    var _sx = _seg_sx + _i * (_seg_w + _seg_gp);
    if (_i < doom) {
        var _iv = 80 + _i * 17;
        draw_set_color(make_color_rgb(min(_iv, 255), 5, 5));
    } else {
        draw_set_color(make_color_rgb(22, 8, 8));
    }
    draw_rectangle(_sx, _seg_y, _sx + _seg_w, _seg_y + _seg_h, false);
    draw_set_color(make_color_rgb(80, 18, 18));
    draw_rectangle(_sx, _seg_y, _sx + _seg_w, _seg_y + _seg_h, true);
}

draw_set_color(make_color_rgb(210, 40, 40));
draw_text_transformed(_seg_sx + _seg_tot + 34, _seg_y + _seg_h / 2,
    string(doom) + "/" + string(MAX_DOOM), 1.15, 1.15, 0);

// Ante & Blind
draw_set_color(make_color_rgb(255, 220, 80));
draw_text_transformed(400, 48,
    "Ante " + string(ante) + " / " + string(MAX_ANTE) + "   " + blind_names[blind_idx], 1.5, 1.5, 0);

// Score / Target
var _disp_score = round(display_score);
if (_disp_score < 0) _disp_score = 0;
if (round_score >= target_score) { draw_set_color(make_color_rgb(255, 80, 80)); }
else                             { draw_set_color(make_color_rgb(215, 175, 175)); }
draw_text_transformed(400, 74, string(_disp_score) + "  /  " + string(target_score), 2.3, 2.3, 0);

// Progress bar
var _bar_x = 190;
var _bar_y = 96;
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

// Stats bar
var _sy = 122;
draw_set_color(make_color_rgb(150, 200, 255));
draw_text_transformed(161, _sy, "Hands: " + string(hands_left), 1.35, 1.35, 0);
draw_set_color(make_color_rgb(255, 190, 130));
draw_text_transformed(401, _sy, "Discards: " + string(discards_left), 1.35, 1.35, 0);
draw_set_color(make_color_rgb(255, 235, 60));
draw_text_transformed(641, _sy, "$" + string(money), 1.35, 1.35, 0);

// Scoring info area
if (last_hand_type >= 0 && score_anim_timer > 0) {
    draw_set_color(make_color_rgb(255, 210, 55));
    draw_text_transformed(400, 298, hand_type_name(last_hand_type), 2.0, 2.0, 0);
    var _formula = string(last_chips) + " Chips  x  " + string(last_mult) + " Mult  =  +" + string(last_score);
    draw_set_color(make_color_rgb(200, 155, 155));
    draw_text_transformed(400, 330, _formula, 1.45, 1.45, 0);
}

// Active doom effects notice
var _notice_y = 360;
if (frozen_card_rank >= 0 && doom_active(2)) {
    draw_set_color(make_color_rgb(120, 120, 255));
    draw_text_transformed(400, _notice_y,
        "FROZEN: " + rank_display(frozen_card_rank) + " of " + suit_display(frozen_card_suit), 1.1, 1.1, 0);
    _notice_y += 22;
}
if (forgotten_hand >= 0 && doom_active(12) && !doom_channeled_id(12)) {
    draw_set_color(make_color_rgb(180, 80, 80));
    draw_text_transformed(400, _notice_y,
        "FORGOTTEN: " + hand_type_name(forgotten_hand), 1.1, 1.1, 0);
    _notice_y += 22;
}
if (sacrifice_rank >= 0 && doom_active(6)) {
    draw_set_color(make_color_rgb(200, 60, 60));
    draw_text_transformed(400, _notice_y,
        "SACRIFICED: " + rank_display(sacrifice_rank) + " of " + suit_display(sacrifice_suit), 1.1, 1.1, 0);
}

// Selected count
if (phase == PHASE_PLAY) {
    var _sel_n = count_selected();
    if (_sel_n > 0) {
        draw_set_color(make_color_rgb(220, 100, 100));
        draw_text_transformed(400, 420, string(_sel_n) + " card(s) selected", 1.25, 1.25, 0);
    }
}

// ============================================================
// DOOM CARDS AREA
// ============================================================
var _doom_label_y = DOOM_Y - DC_H / 2 - 16;
draw_set_color(make_color_rgb(180, 40, 40));
draw_text_transformed(400, _doom_label_y, "DOOM CARDS", 1.2, 1.2, 0);

for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
    var _dx  = get_doom_slot_x(_i);
    var _dy  = DOOM_Y - DC_H / 2;
    var _id  = doom_slots[_i];
    var _ctr_x = _dx + DC_W / 2;

    if (_id < 0) {
        draw_set_color(make_color_rgb(18, 4, 4));
        draw_rectangle(_dx, _dy, _dx + DC_W, _dy + DC_H, false);
        draw_set_color(make_color_rgb(48, 14, 14));
        draw_rectangle(_dx, _dy, _dx + DC_W, _dy + DC_H, true);
        draw_set_color(make_color_rgb(60, 18, 18));
        draw_text_transformed(_ctr_x, DOOM_Y, "empty", 0.88, 0.88, 0);
    } else {
        if (doom_channeled[_i]) {
            draw_set_color(make_color_rgb(12, 4, 28));
        } else {
            draw_set_color(make_color_rgb(32, 4, 4));
        }
        draw_rectangle(_dx, _dy, _dx + DC_W, _dy + DC_H, false);

        if (doom_channeled[_i]) { draw_set_color(make_color_rgb(90, 35, 160)); }
        else                    { draw_set_color(make_color_rgb(130, 18, 18)); }
        draw_rectangle(_dx, _dy, _dx + DC_W, _dy + DC_H, true);

        if (doom_channeled[_i]) { draw_set_color(make_color_rgb(160, 105, 230)); }
        else                    { draw_set_color(make_color_rgb(230, 55, 55)); }
        draw_text_transformed(_ctr_x, _dy + 14, doom_names[_id], 0.9, 0.9, 0);

        draw_set_color(make_color_rgb(165, 115, 115));
        draw_text_transformed(_ctr_x, _dy + 40, doom_passives[_id], 0.58, 0.58, 0);
        draw_text_transformed(_ctr_x, _dy + 60, doom_channels[_id], 0.52, 0.52, 0);

        if (!doom_channeled[_i] && !doom_inhibited[_i] && doom < MAX_DOOM - 1) {
            var _btn_hov = point_in_rectangle(mouse_x, mouse_y,
                _dx + 6, _dy + DC_H - 26, _dx + DC_W - 6, _dy + DC_H - 5);
            if (_btn_hov) { draw_set_color(make_color_rgb(200, 22, 22)); }
            else          { draw_set_color(make_color_rgb(100, 10, 10)); }
            draw_rectangle(_dx + 6, _dy + DC_H - 26, _dx + DC_W - 6, _dy + DC_H - 5, false);
            draw_set_color(c_white);
            draw_text_transformed(_ctr_x, _dy + DC_H - 15, "INVOKE", 0.72, 0.72, 0);
        } else if (doom_channeled[_i]) {
            draw_set_color(make_color_rgb(55, 30, 100));
            draw_rectangle(_dx + 6, _dy + DC_H - 26, _dx + DC_W - 6, _dy + DC_H - 5, false);
            draw_set_color(make_color_rgb(130, 90, 190));
            draw_text_transformed(_ctr_x, _dy + DC_H - 15, "INVOKED", 0.72, 0.72, 0);
        } else {
            draw_set_color(make_color_rgb(40, 10, 10));
            draw_rectangle(_dx + 6, _dy + DC_H - 26, _dx + DC_W - 6, _dy + DC_H - 5, false);
            draw_set_color(make_color_rgb(90, 40, 40));
            draw_text_transformed(_ctr_x, _dy + DC_H - 15, "LOCKED", 0.72, 0.72, 0);
        }
    }
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
draw_text_transformed(159, BTN_Y + BTN_H / 2, "Play Hand", 1.45, 1.45, 0);

var _b2h = point_in_rectangle(mouse_x, mouse_y, 298, BTN_Y, 502, BTN_Y + BTN_H);
if (_can_disc && _b2h) { draw_set_color(make_color_rgb(148, 15, 15)); }
else if (_can_disc)    { draw_set_color(make_color_rgb(80, 8, 8)); }
else                   { draw_set_color(make_color_rgb(28, 5, 5)); }
draw_rectangle(298, BTN_Y, 502, BTN_Y + BTN_H, false);
draw_set_color(c_white);
draw_rectangle(298, BTN_Y, 502, BTN_Y + BTN_H, true);
if (_can_disc) { draw_set_color(c_white); }
else           { draw_set_color(make_color_rgb(70, 28, 28)); }
draw_text_transformed(400, BTN_Y + BTN_H / 2, "Discard (" + string(discards_left) + ")", 1.45, 1.45, 0);

var _b3h = point_in_rectangle(mouse_x, mouse_y, 542, BTN_Y, 740, BTN_Y + BTN_H);
if (_b3h) { draw_set_color(make_color_rgb(80, 10, 10)); }
else      { draw_set_color(make_color_rgb(40, 5, 5)); }
draw_rectangle(542, BTN_Y, 740, BTN_Y + BTN_H, false);
draw_set_color(c_white);
draw_rectangle(542, BTN_Y, 740, BTN_Y + BTN_H, true);
draw_set_color(c_white);
var _slabel = "Sort: Rank";
if (sort_mode != 0) _slabel = "Sort: Suit";
draw_text_transformed(641, BTN_Y + BTN_H / 2, _slabel, 1.45, 1.45, 0);

// ============================================================
// ROUND WIN / LOSE OVERLAY
// ============================================================
if (phase == PHASE_ROUND_WIN || phase == PHASE_ROUND_LOSE) {
    draw_set_color(c_black);
    draw_set_alpha(0.72);
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
    draw_set_color(make_color_rgb(210, 155, 155));
    draw_text_transformed(400, 420, result_msg, 1.35, 1.35, 0);
    draw_set_alpha(0.5 + sin(phase_timer * 0.12) * 0.5);
    draw_set_color(c_white);
    draw_text_transformed(400, 470, "Click to continue...", 1.15, 1.15, 0);
    draw_set_alpha(1);
}
