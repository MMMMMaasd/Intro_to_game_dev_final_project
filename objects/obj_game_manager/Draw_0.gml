draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_score);

draw_set_color(make_color_rgb(6, 0, 0));
draw_rectangle(0, 0, 800, 800, false);
draw_set_color(make_color_rgb(18, 3, 3));
draw_ellipse(30, 30, 770, 770, false);
draw_set_color(make_color_rgb(80, 8, 8));
draw_ellipse(35, 35, 765, 765, true);
draw_set_color(make_color_rgb(40, 0, 0));
draw_ellipse(60, 60, 740, 740, true);

if (phase == PHASE_MENU) {
    draw_set_color(make_color_rgb(60, 0, 0));
    draw_text_transformed(405, 287, "BALATRO", 4.5, 4.5, 0);
    draw_set_color(make_color_rgb(200, 15, 15));
    draw_text_transformed(402, 284, "BALATRO", 4.5, 4.5, 0);
    draw_set_color(make_color_rgb(255, 60, 60));
    draw_text_transformed(400, 281, "BALATRO", 4.5, 4.5, 0);
    draw_set_color(make_color_rgb(50, 0, 0));
    draw_text_transformed(402, 392, "Click anywhere to start", 1.7, 1.7, 0);
    draw_set_color(make_color_rgb(200, 150, 150));
    draw_text_transformed(400, 390, "Click anywhere to start", 1.7, 1.7, 0);
    return;
}

if (phase == PHASE_GAMEOVER) {
    draw_set_color(c_black);
    draw_set_alpha(0.72);
    draw_rectangle(0, 0, 800, 800, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(220, 50, 50));
    draw_text_transformed(400, 310, "GAME OVER", 4, 4, 0);
    draw_set_color(c_white);
    draw_text_transformed(400, 420, "Click to Restart", 1.9, 1.9, 0);
    return;
}

if (phase == PHASE_WIN) {
    draw_set_color(c_black);
    draw_set_alpha(0.72);
    draw_rectangle(0, 0, 800, 800, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(255, 215, 0));
    draw_text_transformed(400, 290, "YOU WIN!", 4, 4, 0);
    draw_set_color(c_white);
    draw_text_transformed(400, 390, "All " + string(MAX_ANTE) + " Antes Cleared!", 2, 2, 0);
    draw_text_transformed(400, 450, "Click to Restart", 1.7, 1.7, 0);
    return;
}

// === SHOP SCREEN ===
if (phase == PHASE_SHOP) {
    draw_set_color(c_black);
    draw_set_alpha(0.88);
    draw_rectangle(0, 0, 800, 800, false);
    draw_set_alpha(1);

    draw_set_color(make_color_rgb(255, 195, 40));
    draw_text_transformed(400, 70, "SHOP", 3.8, 3.8, 0);
    draw_set_color(make_color_rgb(200, 200, 200));
    draw_text_transformed(400, 145, "$" + string(money) + "  available", 1.9, 1.9, 0);

    var _slot_x = [210, 590];
    for (var _i = 0; _i < 2; _i++) {
        var _sx  = _slot_x[_i];
        var _jid = shop_offers[_i];
        if (_jid >= 0) {
            var _can = (money >= shop_prices[_i]) && (owned_joker_count < MAX_JOKERS);
            if (_can) {
                draw_set_color(make_color_rgb(35, 12, 70));
            } else {
                draw_set_color(make_color_rgb(22, 22, 22));
            }
            draw_rectangle(_sx - 100, 220, _sx + 100, 490, false);
            if (_can) {
                draw_set_color(make_color_rgb(140, 70, 210));
            } else {
                draw_set_color(make_color_rgb(70, 70, 70));
            }
            draw_rectangle(_sx - 100, 220, _sx + 100, 490, true);
            draw_set_color(c_white);
            draw_text_transformed(_sx, 300, joker_names[_jid], 1.4, 1.4, 0);
            draw_set_color(make_color_rgb(210, 210, 100));
            draw_text_transformed(_sx, 360, joker_descs[_jid], 1.05, 1.05, 0);
            draw_set_color(make_color_rgb(255, 235, 60));
            draw_text_transformed(_sx, 430, "$" + string(shop_prices[_i]), 2.2, 2.2, 0);
            if (_can) {
                draw_set_color(make_color_rgb(100, 220, 110));
                draw_text_transformed(_sx, 472, "Click to Buy", 1.1, 1.1, 0);
            } else if (owned_joker_count >= MAX_JOKERS) {
                draw_set_color(make_color_rgb(200, 80, 80));
                draw_text_transformed(_sx, 472, "Slots Full", 1.1, 1.1, 0);
            } else {
                draw_set_color(make_color_rgb(200, 80, 80));
                draw_text_transformed(_sx, 472, "Can't Afford", 1.1, 1.1, 0);
            }
        } else {
            draw_set_color(make_color_rgb(25, 25, 25));
            draw_rectangle(_sx - 100, 220, _sx + 100, 490, false);
            draw_set_color(make_color_rgb(55, 55, 55));
            draw_rectangle(_sx - 100, 220, _sx + 100, 490, true);
            draw_set_color(make_color_rgb(90, 90, 90));
            draw_text_transformed(_sx, 355, "Sold Out", 1.5, 1.5, 0);
        }
    }

    draw_set_color(make_color_rgb(180, 145, 55));
    draw_text_transformed(400, 522, "Your Jokers:", 1.4, 1.4, 0);
    for (var _i = 0; _i < MAX_JOKERS; _i++) {
        var _ox  = 168 + _i * 100;
        var _oy  = 580;
        var _jid = owned_jokers[_i];
        if (_jid >= 0) {
            draw_set_color(make_color_rgb(75, 35, 115));
            draw_rectangle(_ox - 42, _oy - 32, _ox + 42, _oy + 32, false);
            draw_set_color(make_color_rgb(145, 75, 215));
            draw_rectangle(_ox - 42, _oy - 32, _ox + 42, _oy + 32, true);
            draw_set_color(c_white);
            draw_text_transformed(_ox, _oy - 8, joker_names[_jid], 0.78, 0.78, 0);
        } else {
            draw_set_color(make_color_rgb(28, 28, 28));
            draw_rectangle(_ox - 42, _oy - 32, _ox + 42, _oy + 32, false);
            draw_set_color(make_color_rgb(55, 55, 55));
            draw_rectangle(_ox - 42, _oy - 32, _ox + 42, _oy + 32, true);
        }
    }

    var _nr_hov = point_in_rectangle(mouse_x, mouse_y, 300, 630, 500, 700);
    if (_nr_hov) {
        draw_set_color(make_color_rgb(70, 155, 70));
    } else {
        draw_set_color(make_color_rgb(35, 95, 35));
    }
    draw_rectangle(300, 630, 500, 700, false);
    draw_set_color(c_white);
    draw_rectangle(300, 630, 500, 700, true);
    draw_set_color(c_white);
    draw_text_transformed(400, 665, "Next Round", 1.6, 1.6, 0);
    return;
}

// === HEADER ===
draw_set_color(c_black);
draw_text_transformed(402, 22, "Ante " + string(ante) + "/" + string(MAX_ANTE) + "   " + blind_names[blind_idx], 1.5, 1.5, 0);
draw_set_color(make_color_rgb(255, 225, 90));
draw_text_transformed(400, 21, "Ante " + string(ante) + "/" + string(MAX_ANTE) + "   " + blind_names[blind_idx], 1.5, 1.5, 0);

var _score_label = string(round(display_score)) + " / " + string(target_score);
draw_set_color(c_black);
draw_text_transformed(402, 57, _score_label, 2.3, 2.3, 0);
if (round_score >= target_score) {
    draw_set_color(make_color_rgb(255, 80, 80));
} else {
    draw_set_color(make_color_rgb(210, 170, 170));
}
draw_text_transformed(400, 56, _score_label, 2.3, 2.3, 0);

var _bar_x = 200;
var _bar_y = 93;
var _bar_w = 400;
var _bar_h = 14;
draw_set_color(make_color_rgb(35, 35, 35));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);
var _prog = min(round_score / max(target_score, 1), 1.0);
draw_set_color(make_color_rgb(190, 15, 15));
if (_prog > 0) draw_rectangle(_bar_x, _bar_y, _bar_x + round(_bar_w * _prog), _bar_y + _bar_h, false);
draw_set_color(c_white);
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, true);

// stats bar
var _sy = 120;
draw_set_color(c_black);
draw_text_transformed(162, _sy + 1, "Hands: " + string(hands_left), 1.4, 1.4, 0);
draw_set_color(make_color_rgb(175, 215, 255));
draw_text_transformed(161, _sy, "Hands: " + string(hands_left), 1.4, 1.4, 0);

draw_set_color(c_black);
draw_text_transformed(402, _sy + 1, "Discards: " + string(discards_left), 1.4, 1.4, 0);
draw_set_color(make_color_rgb(255, 195, 140));
draw_text_transformed(401, _sy, "Discards: " + string(discards_left), 1.4, 1.4, 0);

draw_set_color(c_black);
draw_text_transformed(642, _sy + 1, "$" + string(money), 1.4, 1.4, 0);
draw_set_color(make_color_rgb(255, 238, 70));
draw_text_transformed(641, _sy, "$" + string(money), 1.4, 1.4, 0);

// === SCORING DISPLAY ===
if (last_hand_type >= 0) {
    var _hname = hand_type_name(last_hand_type);
    draw_set_color(c_black);
    draw_text_transformed(401, 296, _hname, 2, 2, 0);
    draw_set_color(make_color_rgb(255, 215, 60));
    draw_text_transformed(400, 295, _hname, 2, 2, 0);

    var _formula = string(last_chips) + " Chips  x  " + string(last_mult) + " Mult  =  +" + string(last_score);
    draw_set_color(c_black);
    draw_text_transformed(401, 330, _formula, 1.45, 1.45, 0);
    draw_set_color(c_white);
    draw_text_transformed(400, 329, _formula, 1.45, 1.45, 0);
}

// === JOKER AREA ===
var _jy1 = JOKER_Y - CARD_H / 2 - 6;
var _jy2 = JOKER_Y + CARD_H / 2 + 6;
draw_set_color(make_color_rgb(30, 3, 3));
draw_rectangle(160, _jy1, 640, _jy2, false);
draw_set_color(make_color_rgb(110, 10, 10));
draw_rectangle(160, _jy1, 640, _jy2, true);

draw_set_color(make_color_rgb(220, 60, 60));
draw_text_transformed(400, _jy1 - 18, "Jokers", 1.25, 1.25, 0);

for (var _i = 0; _i < MAX_JOKERS; _i++) {
    var _jx  = 208 + _i * 90;
    var _jid = owned_jokers[_i];
    if (_jid >= 0) {
        draw_set_color(make_color_rgb(28, 8, 58));
        draw_rectangle(_jx - CARD_W / 2, JOKER_Y - CARD_H / 2, _jx + CARD_W / 2, JOKER_Y + CARD_H / 2, false);
        draw_set_color(make_color_rgb(145, 70, 215));
        draw_rectangle(_jx - CARD_W / 2, JOKER_Y - CARD_H / 2, _jx + CARD_W / 2, JOKER_Y + CARD_H / 2, true);
        draw_set_color(c_white);
        draw_text_transformed(_jx, JOKER_Y - 12, joker_names[_jid], 0.74, 0.74, 0);
        draw_set_color(make_color_rgb(200, 195, 90));
        draw_text_transformed(_jx, JOKER_Y + 12, joker_descs[_jid], 0.60, 0.60, 0);
    } else {
        draw_set_color(make_color_rgb(40, 28, 8));
        draw_rectangle(_jx - CARD_W / 2, JOKER_Y - CARD_H / 2, _jx + CARD_W / 2, JOKER_Y + CARD_H / 2, false);
        draw_set_color(make_color_rgb(80, 58, 18));
        draw_rectangle(_jx - CARD_W / 2, JOKER_Y - CARD_H / 2, _jx + CARD_W / 2, JOKER_Y + CARD_H / 2, true);
    }
}

// === ACTION BUTTONS ===
var _can_play = (phase == PHASE_PLAY) && (count_selected() > 0);
var _can_disc = (phase == PHASE_PLAY) && (count_selected() > 0) && (discards_left > 0);

var _b1h = point_in_rectangle(mouse_x, mouse_y, 60, BTN_Y, 258, BTN_Y + BTN_H);
if (_can_play && _b1h) {
    draw_set_color(make_color_rgb(200, 30, 30));
} else if (_can_play) {
    draw_set_color(make_color_rgb(130, 15, 15));
} else {
    draw_set_color(make_color_rgb(45, 10, 10));
}
draw_rectangle(60, BTN_Y, 258, BTN_Y + BTN_H, false);
draw_set_color(c_white);
draw_rectangle(60, BTN_Y, 258, BTN_Y + BTN_H, true);
if (_can_play) {
    draw_set_color(c_white);
} else {
    draw_set_color(make_color_rgb(90, 90, 90));
}
draw_text_transformed(159, BTN_Y + BTN_H / 2, "Play Hand", 1.4, 1.4, 0);

var _b2h = point_in_rectangle(mouse_x, mouse_y, 298, BTN_Y, 502, BTN_Y + BTN_H);
if (_can_disc && _b2h) {
    draw_set_color(make_color_rgb(160, 20, 20));
} else if (_can_disc) {
    draw_set_color(make_color_rgb(90, 10, 10));
} else {
    draw_set_color(make_color_rgb(35, 8, 8));
}
draw_rectangle(298, BTN_Y, 502, BTN_Y + BTN_H, false);
draw_set_color(c_white);
draw_rectangle(298, BTN_Y, 502, BTN_Y + BTN_H, true);
if (_can_disc) {
    draw_set_color(c_white);
} else {
    draw_set_color(make_color_rgb(90, 90, 90));
}
draw_text_transformed(400, BTN_Y + BTN_H / 2, "Discard  (" + string(discards_left) + ")", 1.4, 1.4, 0);

var _b3h = point_in_rectangle(mouse_x, mouse_y, 542, BTN_Y, 740, BTN_Y + BTN_H);
if (_b3h) {
    draw_set_color(make_color_rgb(100, 10, 10));
} else {
    draw_set_color(make_color_rgb(50, 5, 5));
}
draw_rectangle(542, BTN_Y, 740, BTN_Y + BTN_H, false);
draw_set_color(c_white);
draw_rectangle(542, BTN_Y, 740, BTN_Y + BTN_H, true);
draw_set_color(c_white);
var _sort_label = "Sort: Rank";
if (sort_mode != 0) _sort_label = "Sort: Suit";
draw_text_transformed(641, BTN_Y + BTN_H / 2, _sort_label, 1.4, 1.4, 0);

// selected count hint
var _sel_n = count_selected();
if (phase == PHASE_PLAY && _sel_n > 0) {
    draw_set_color(make_color_rgb(255, 215, 60));
    draw_text_transformed(400, 410, string(_sel_n) + " card(s) selected", 1.25, 1.25, 0);
}

// === ROUND WIN / LOSE OVERLAY ===
if (phase == PHASE_ROUND_WIN || phase == PHASE_ROUND_LOSE) {
    draw_set_color(c_black);
    draw_set_alpha(0.65);
    draw_rectangle(160, 290, 640, 490, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(160, 290, 640, 490, true);

    if (phase == PHASE_ROUND_WIN) {
        draw_set_color(make_color_rgb(75, 215, 75));
        draw_text_transformed(400, 355, "Round Won!", 2.6, 2.6, 0);
    } else {
        draw_set_color(make_color_rgb(215, 75, 75));
        draw_text_transformed(400, 355, "Round Lost!", 2.6, 2.6, 0);
    }
    draw_set_color(c_white);
    draw_text_transformed(400, 422, result_msg, 1.4, 1.4, 0);
    draw_text_transformed(400, 464, "Click to continue", 1.15, 1.15, 0);
}
