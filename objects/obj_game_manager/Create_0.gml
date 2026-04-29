randomize();
depth = 10;

PHASE_MENU       = 0;
PHASE_PLAY       = 1;
PHASE_SCORING    = 2;
PHASE_ROUND_WIN  = 3;
PHASE_ROUND_LOSE = 4;
PHASE_SHOP       = 5;
PHASE_GAMEOVER   = 6;
PHASE_WIN        = 7;

phase       = PHASE_MENU;
phase_timer = 0;

CARD_W = 65;
CARD_H = 95;
HAND_Y = 510;
PLAY_Y = 225;
JOKER_Y = 645;
BTN_Y   = 710;
BTN_H   = 52;
DECK_X  = 730;
DECK_Y  = 740;

ante       = 1;
blind_idx  = 0;
MAX_ANTE   = 3;

blind_names  = array_create(3, "");
blind_names[0] = "Small Blind";
blind_names[1] = "Big Blind";
blind_names[2] = "Boss Blind";

ante_bases  = array_create(3, 0);
ante_bases[0] = 300;
ante_bases[1] = 800;
ante_bases[2] = 2000;

blind_mults = array_create(3, 0);
blind_mults[0] = 1.0;
blind_mults[1] = 1.5;
blind_mults[2] = 2.0;

hands_left    = 4;
discards_left = 3;
round_score   = 0;
target_score  = 0;

money = 4;

deck = ds_list_create();

MAX_HAND   = 8;
MAX_PLAY   = 5;
MAX_JOKERS = 5;

hand_cards = array_create(MAX_HAND, noone);
play_cards = array_create(MAX_PLAY, noone);
hand_count = 0;
play_count = 0;

owned_jokers      = array_create(MAX_JOKERS, -1);
owned_joker_count = 0;

JOKER_TOTAL = 8;

joker_names = array_create(JOKER_TOTAL, "");
joker_names[0] = "Joker";
joker_names[1] = "Jolly Joker";
joker_names[2] = "Zany Joker";
joker_names[3] = "Mad Joker";
joker_names[4] = "Crazy Joker";
joker_names[5] = "Droll Joker";
joker_names[6] = "Half Joker";
joker_names[7] = "Scary Face";

joker_costs = array_create(JOKER_TOTAL, 0);
joker_costs[0] = 3;
joker_costs[1] = 4;
joker_costs[2] = 4;
joker_costs[3] = 5;
joker_costs[4] = 4;
joker_costs[5] = 4;
joker_costs[6] = 5;
joker_costs[7] = 3;

joker_descs = array_create(JOKER_TOTAL, "");
joker_descs[0] = "+4 Mult";
joker_descs[1] = "+8 Mult if Pair";
joker_descs[2] = "+12 Mult if 3-of-a-Kind";
joker_descs[3] = "+20 Mult if Two Pair";
joker_descs[4] = "+15 Mult if Straight";
joker_descs[5] = "+10 Mult if Flush";
joker_descs[6] = "+20 Mult if 3 or fewer cards";
joker_descs[7] = "+30 Chips per face card";

shop_offers = array_create(2, -1);
shop_prices = array_create(2, 0);

last_hand_type = -1;
last_chips     = 0;
last_mult      = 0;
last_score     = 0;
score_anim_timer = 0;
display_score    = 0;

sort_mode  = 0;
result_msg = "";

get_hand_card_x = function(slot) {
    var _spacing = CARD_W + 8;
    var _total_w = MAX_HAND * CARD_W + (MAX_HAND - 1) * 8;
    var _start   = 400 - _total_w / 2 + CARD_W / 2;
    return _start + slot * _spacing;
};

get_play_card_x = function(slot, total) {
    var _spacing = CARD_W + 8;
    var _total_w = total * CARD_W + (total - 1) * 8;
    var _start   = 400 - _total_w / 2 + CARD_W / 2;
    return _start + slot * _spacing;
};

get_target = function() {
    return round(ante_bases[ante - 1] * blind_mults[blind_idx]);
};

rebuild_deck = function() {
    ds_list_clear(deck);
    for (var _s = 0; _s < 4; _s++)
        for (var _r = 2; _r <= 14; _r++)
            ds_list_add(deck, (_r - 2) * 4 + _s);
    ds_list_shuffle(deck);
};

update_hand_count = function() {
    hand_count = 0;
    for (var _i = 0; _i < MAX_HAND; _i++)
        if (instance_exists(hand_cards[_i])) hand_count++;
};

deal_to_hand = function() {
    for (var _i = 0; _i < MAX_HAND; _i++) {
        if (!instance_exists(hand_cards[_i]) && ds_list_size(deck) > 0) {
            var _enc  = deck[| 0];
            ds_list_delete(deck, 0);
            var _rank = (_enc div 4) + 2;
            var _suit = _enc mod 4;
            var _inst = instance_create_layer(DECK_X, DECK_Y, "Instances", obj_card);
            _inst.card_rank   = _rank;
            _inst.card_suit   = _suit;
            _inst.card_sprite = get_card_sprite(_rank, _suit);
            _inst.face_down   = false;
            _inst.target_x    = get_hand_card_x(_i);
            _inst.target_y    = HAND_Y;
            _inst.selected    = false;
            _inst.in_hand     = true;
            _inst.slot_idx    = _i;
            hand_cards[_i]    = _inst;
        }
    }
    update_hand_count();
};

reposition_hand = function() {
    for (var _i = 0; _i < MAX_HAND; _i++) {
        if (instance_exists(hand_cards[_i])) {
            hand_cards[_i].target_x = get_hand_card_x(_i);
            hand_cards[_i].target_y = HAND_Y;
            hand_cards[_i].slot_idx = _i;
        }
    }
};

compact_hand = function() {
    var _new = array_create(MAX_HAND, noone);
    var _idx = 0;
    for (var _i = 0; _i < MAX_HAND; _i++) {
        if (instance_exists(hand_cards[_i])) {
            _new[_idx] = hand_cards[_i];
            _idx++;
        }
    }
    hand_cards = _new;
    update_hand_count();
    reposition_hand();
};

count_selected = function() {
    var _c = 0;
    for (var _i = 0; _i < MAX_HAND; _i++)
        if (instance_exists(hand_cards[_i]) && hand_cards[_i].selected) _c++;
    return _c;
};

get_selected = function() {
    var _arr = [];
    var _n   = 0;
    for (var _i = 0; _i < MAX_HAND; _i++) {
        if (instance_exists(hand_cards[_i]) && hand_cards[_i].selected) {
            _arr[_n] = hand_cards[_i];
            _n++;
        }
    }
    return _arr;
};

discard_selected = function() {
    if (discards_left <= 0) return;
    var _any = false;
    for (var _i = 0; _i < MAX_HAND; _i++) {
        if (instance_exists(hand_cards[_i]) && hand_cards[_i].selected) {
            instance_destroy(hand_cards[_i]);
            hand_cards[_i] = noone;
            _any = true;
        }
    }
    if (_any) {
        discards_left--;
        compact_hand();
        deal_to_hand();
    }
};

sort_hand = function() {
    for (var _i = 1; _i < MAX_HAND; _i++) {
        if (!instance_exists(hand_cards[_i])) continue;
        var _key = hand_cards[_i];
        var _j   = _i - 1;
        while (_j >= 0) {
            if (!instance_exists(hand_cards[_j])) {
                _j--;
                continue;
            }
            var _va = 0;
            var _vb = 0;
            if (sort_mode == 0) {
                _va = hand_cards[_j].card_rank;
                _vb = _key.card_rank;
            } else {
                _va = hand_cards[_j].card_suit;
                _vb = _key.card_suit;
            }
            if (_va > _vb) {
                hand_cards[_j + 1] = hand_cards[_j];
                _j--;
            } else {
                break;
            }
        }
        hand_cards[_j + 1] = _key;
    }
    reposition_hand();
};

eval_partial = function(ranks, suits, n) {
    if (n <= 0) return [0, 0, 0, 0, 0, 0];
    var _cnt = array_create(15, 0);
    for (var _i = 0; _i < n; _i++) _cnt[ranks[_i]]++;
    var _max_same = 0;
    var _pairs    = 0;
    for (var _r = 2; _r <= 14; _r++) {
        if (_cnt[_r] > _max_same) _max_same = _cnt[_r];
        if (_cnt[_r] == 2) _pairs++;
    }
    if (_max_same == 4) return [7, 0, 0, 0, 0, 0];
    if (_max_same == 3 && _pairs >= 1) return [6, 0, 0, 0, 0, 0];
    if (_max_same == 3) return [3, 0, 0, 0, 0, 0];
    if (_pairs >= 2) return [2, 0, 0, 0, 0, 0];
    if (_pairs == 1) return [1, 0, 0, 0, 0, 0];
    return [0, ranks[0], 0, 0, 0, 0];
};

joker_mult_bonus = function(hand_type, n_played) {
    var _bonus = 0;
    for (var _i = 0; _i < MAX_JOKERS; _i++) {
        var _jid = owned_jokers[_i];
        if (_jid < 0) continue;
        if (_jid == 0) { _bonus += 4; }
        else if (_jid == 1 && hand_type == 1) { _bonus += 8; }
        else if (_jid == 2 && hand_type == 3) { _bonus += 12; }
        else if (_jid == 3 && hand_type == 2) { _bonus += 20; }
        else if (_jid == 4 && hand_type == 4) { _bonus += 15; }
        else if (_jid == 5 && hand_type == 5) { _bonus += 10; }
        else if (_jid == 6 && n_played <= 3)  { _bonus += 20; }
    }
    return _bonus;
};

joker_chip_bonus = function(cards_arr) {
    var _bonus = 0;
    var _n     = array_length(cards_arr);
    for (var _i = 0; _i < MAX_JOKERS; _i++) {
        var _jid = owned_jokers[_i];
        if (_jid < 0) continue;
        if (_jid == 7) {
            for (var _ci = 0; _ci < _n; _ci++) {
                var _r = cards_arr[_ci].card_rank;
                if (_r >= 11 && _r <= 13) _bonus += 30;
            }
        }
    }
    return _bonus;
};

compute_score = function(cards_arr) {
    var _n     = array_length(cards_arr);
    var _ranks = [];
    var _suits = [];
    for (var _i = 0; _i < _n; _i++) {
        _ranks[_i] = cards_arr[_i].card_rank;
        _suits[_i] = cards_arr[_i].card_suit;
    }

    var _hs;
    if (_n >= 5) {
        _hs = best_5_from_n(_ranks, _suits);
    } else {
        _hs = eval_partial(_ranks, _suits, _n);
    }

    last_hand_type = _hs[0];

    var _base  = hand_base_score(last_hand_type);
    var _chips = _base[0];
    var _mult  = _base[1];

    for (var _i = 0; _i < _n; _i++)
        _chips += card_chip_value(cards_arr[_i].card_rank);

    _chips += joker_chip_bonus(cards_arr);
    _mult  += joker_mult_bonus(last_hand_type, _n);

    last_chips = _chips;
    last_mult  = _mult;
    last_score = _chips * _mult;
    round_score += last_score;
};

play_hand = function() {
    var _sel = get_selected();
    var _n   = array_length(_sel);
    if (_n == 0) return;

    play_count = _n;
    for (var _i = 0; _i < _n; _i++) {
        var _inst    = _sel[_i];
        _inst.target_x = get_play_card_x(_i, _n);
        _inst.target_y = PLAY_Y;
        _inst.in_hand  = false;
        _inst.selected = false;
        play_cards[_i] = _inst;
        for (var _j = 0; _j < MAX_HAND; _j++)
            if (hand_cards[_j] == _inst) hand_cards[_j] = noone;
    }

    compact_hand();
    compute_score(_sel);
    hands_left--;

    phase            = PHASE_SCORING;
    phase_timer      = 0;
    score_anim_timer = 0;
    display_score    = round_score - last_score;
    audio_play_sound(snd_card, 1, false);
};

clear_play_area = function() {
    for (var _i = 0; _i < MAX_PLAY; _i++) {
        if (instance_exists(play_cards[_i])) instance_destroy(play_cards[_i]);
        play_cards[_i] = noone;
    }
    play_count = 0;
};

init_round = function() {
    with (obj_card) instance_destroy();
    for (var _i = 0; _i < MAX_HAND; _i++) hand_cards[_i] = noone;
    for (var _i = 0; _i < MAX_PLAY; _i++) play_cards[_i] = noone;

    hands_left    = 4;
    discards_left = 3;
    round_score   = 0;
    play_count    = 0;
    target_score  = get_target();

    last_hand_type   = -1;
    last_chips       = 0;
    last_mult        = 0;
    last_score       = 0;
    display_score    = 0;
    score_anim_timer = 0;

    rebuild_deck();
    deal_to_hand();
};

setup_shop = function() {
    var _avail = [];
    var _ac    = 0;
    for (var _jid = 0; _jid < JOKER_TOTAL; _jid++) {
        var _owned = false;
        for (var _i = 0; _i < MAX_JOKERS; _i++)
            if (owned_jokers[_i] == _jid) _owned = true;
        if (!_owned) {
            _avail[_ac] = _jid;
            _ac++;
        }
    }
    _avail = shuffle_array(_avail);

    if (_ac > 0) {
        shop_offers[0] = _avail[0];
        shop_prices[0] = joker_costs[_avail[0]];
    } else {
        shop_offers[0] = -1;
        shop_prices[0] = 0;
    }
    if (_ac > 1) {
        shop_offers[1] = _avail[1];
        shop_prices[1] = joker_costs[_avail[1]];
    } else {
        shop_offers[1] = -1;
        shop_prices[1] = 0;
    }
};

var _bgm = audio_play_sound(snd_bgm, 0, true);
audio_sound_gain(_bgm, 0.2, 0);
