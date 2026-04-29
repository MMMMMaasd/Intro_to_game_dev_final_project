var _x1 = x - card_w / 2;
var _y1 = y - card_h / 2 - hover_rise;
var _x2 = x + card_w / 2;
var _y2 = y + card_h / 2 - hover_rise;

if (face_down) {
    draw_sprite_stretched(spr_card_back, 0, _x1, _y1, card_w, card_h);
} else {
    if (card_sprite < 0) {
        card_sprite = get_card_sprite(card_rank, card_suit);
    }
    if (card_sprite >= 0) {
        draw_sprite_stretched(card_sprite, 0, _x1, _y1, card_w, card_h);
    } else {
        draw_set_color(c_white);
        draw_rectangle(_x1, _y1, _x2, _y2, false);
        draw_set_color(c_red);
        draw_rectangle(_x1, _y1, _x2, _y2, true);
    }
    if (selected) {
        draw_set_color(make_color_rgb(255, 215, 0));
        draw_rectangle(_x1 - 3, _y1 - 3, _x2 + 3, _y2 + 3, true);
    }
}
