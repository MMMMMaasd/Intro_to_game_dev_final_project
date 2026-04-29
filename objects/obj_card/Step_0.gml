x = lerp(x, target_x, 0.2);
y = lerp(y, target_y, 0.2);

if (in_hand) {
    var _hov = point_in_rectangle(mouse_x, mouse_y,
        x - card_w / 2, y - card_h / 2 - 20,
        x + card_w / 2, y + card_h / 2);
    var _target_rise = 0;
    if (selected) {
        _target_rise = 28;
    } else if (_hov) {
        _target_rise = 14;
    }
    hover_rise = lerp(hover_rise, _target_rise, 0.25);
} else {
    hover_rise = lerp(hover_rise, 0, 0.2);
}
