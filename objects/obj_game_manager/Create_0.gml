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
PHASE_JUMPSCARE  = 8;

phase            = PHASE_MENU;
phase_timer      = 0;
post_scare_phase = PHASE_PLAY;

CARD_W  = 65;
CARD_H  = 95;
HAND_Y  = 490;
PLAY_Y  = 225;
DC_W    = 110;
DC_H    = 108;
DC_GAP  = 12;
DOOM_Y  = 635;
BTN_Y   = 703;
BTN_H   = 50;
DECK_X  = 730;
DECK_Y  = 750;

ante      = 1;
blind_idx = 0;
MAX_ANTE  = 3;

blind_names = array_create(3, "");
blind_names[0] = "The Lurking";
blind_names[1] = "The Wailing";
blind_names[2] = "The Devouring";

ante_bases = array_create(3, 0);
ante_bases[0] = 300;
ante_bases[1] = 800;
ante_bases[2] = 2000;

blind_mults = array_create(3, 0);
blind_mults[0] = 1.0;
blind_mults[1] = 1.5;
blind_mults[2] = 2.0;

hands_left     = 4;
discards_left  = 3;
extra_hands    = 0;
extra_discards = 0;
round_score    = 0;
target_score   = 0;

money = 4;

doom     = 0;
MAX_DOOM = 10;

jumpscare_chance  = 0.08;
jumpscare_protect = false;
jumpscare_timer   = 0;

scare_msgs = array_create(8, "");
scare_msgs[0] = "IT'S BEHIND YOU";
scare_msgs[1] = "YOU CAN'T RUN";
scare_msgs[2] = "IT SEES YOU";
scare_msgs[3] = "THE DOOM IS NEAR";
scare_msgs[4] = "LOOK AWAY";
scare_msgs[5] = "DO NOT LOOK";
scare_msgs[6] = "YOU ARE ALREADY DEAD";
scare_msgs[7] = "IT FOUND YOU";
current_scare_msg = "";

MAX_DOOM_SLOTS  = 5;
DOOM_CARD_COUNT = 15;

doom_slots     = array_create(MAX_DOOM_SLOTS, -1);
doom_channeled = array_create(MAX_DOOM_SLOTS, false);
doom_inhibited = array_create(MAX_DOOM_SLOTS, false);
doom_count     = 0;

doom_names = array_create(DOOM_CARD_COUNT, "");
doom_names[0]  = "Blood Moon";
doom_names[1]  = "Ghost Hand";
doom_names[2]  = "Evil Eye";
doom_names[3]  = "Midnight Bell";
doom_names[4]  = "Meat Hook";
doom_names[5]  = "Decay";
doom_names[6]  = "Sacrifice";
doom_names[7]  = "Eternal Night";
doom_names[8]  = "Bloodthirst";
doom_names[9]  = "Last Judgment";
doom_names[10] = "Grim Gaze";
doom_names[11] = "Screaming Jester";
doom_names[12] = "Oblivion";
doom_names[13] = "Hell Contract";
doom_names[14] = "Maggot Bet";

doom_passives = array_create(DOOM_CARD_COUNT, "");
doom_passives[0]  = "Round start: -1 Gold";
doom_passives[1]  = "After each hand: lose a card";
doom_passives[2]  = "Round start: 1 card frozen";
doom_passives[3]  = "Flush played: Doom+3";
doom_passives[4]  = "<4 cards played: Doom+2";
doom_passives[5]  = "Round start: -2 Gold";
doom_passives[6]  = "Round start: lose lowest card";
doom_passives[7]  = "Round start: Hands-1 (min 1)";
doom_passives[8]  = "Each face card played: Doom+1";
doom_passives[9]  = "Doom>=8 at round end: death";
doom_passives[10] = "Score<50% of target: Doom+1";
doom_passives[11] = "Jumpscare chance +40%";
doom_passives[12] = "One hand type forgotten/round";
doom_passives[13] = "Doom never decreases on win";
doom_passives[14] = "Each hand played: Mult-1";

doom_channels = array_create(DOOM_CARD_COUNT, "");
doom_channels[0]  = "[+2 Doom] This hand: Chips x3";
doom_channels[1]  = "[+2 Doom] Next round: +4 hand size";
doom_channels[2]  = "[+2 Doom] Frozen card = +50 Mult";
doom_channels[3]  = "[+2 Doom] Next Flush = instant win";
doom_channels[4]  = "[+2 Doom] Extra cards: +30 Chips each";
doom_channels[5]  = "[+2 Doom] This hand: +10 Mult";
doom_channels[6]  = "[+2 Doom] Sacrificed card = +40 Chips + Doom-3";
doom_channels[7]  = "[+2 Doom] Unlimited hands (Doom+1 each)";
doom_channels[8]  = "[+2 Doom] Face cards = +60 Chips each";
doom_channels[9]  = "[+2 Doom] Set Doom to 5 + 200 Chips";
doom_channels[10] = "[+2 Doom] Score jumps to 60% of target";
doom_channels[11] = "[+2 Doom] Next jumpscare = +20 Mult reward";
doom_channels[12] = "[+2 Doom] All hand types score + Mult x2";
doom_channels[13] = "[+2 Doom] +150 Chips and +8 Mult";
doom_channels[14] = "[+2 Doom] Reset penalty + Mult x2";

SHOP_BOON_COUNT = 4;
shop_boon_names = array_create(SHOP_BOON_COUNT, "");
shop_boon_names[0] = "Soul Comfort";
shop_boon_names[1] = "Life Talisman";
shop_boon_names[2] = "Forget Rune";
shop_boon_names[3] = "Demon Deal";

shop_boon_descs = array_create(SHOP_BOON_COUNT, "");
shop_boon_descs[0] = "Doom -2";
shop_boon_descs[1] = "+1 Hand next round";
shop_boon_descs[2] = "+2 Discards next round";
shop_boon_descs[3] = "Force a new doom card  +Doom+1  (free)";

shop_boon_costs = array_create(SHOP_BOON_COUNT, 0);
shop_boon_costs[0] = 8;
shop_boon_costs[1] = 6;
shop_boon_costs[2] = 4;
shop_boon_costs[3] = 0;

shop_offers = array_create(2, -1);

deck = ds_list_create();

MAX_HAND = 8;
MAX_PLAY = 5;

hand_cards      = array_create(MAX_HAND, noone);
play_cards      = array_create(MAX_PLAY, noone);
hand_count      = 0;
play_count      = 0;
hand_size_bonus = 0;

last_hand_type   = -1;
last_chips       = 0;
last_mult        = 0;
last_score       = 0;
score_anim_timer = 0;
display_score    = 0;

sort_mode      = 0;
result_msg     = "";
forgotten_hand = -1;
mult_penalty   = 0;

frozen_card_rank  = -1;
frozen_card_suit  = -1;
midnight_auto_win = false;
sacrifice_rank    = -1;
sacrifice_suit    = -1;

add_doom = function(n) {
    doom += n;
    if (doom > MAX_DOOM) doom = MAX_DOOM;
    if (doom < 0) doom = 0;
};

doom_active = function(id) {
    for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
        if (doom_slots[_i] == id && !doom_inhibited[_i]) return true;
    }
    return false;
};

doom_channeled_id = function(id) {
    for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
        if (doom_slots[_i] == id && doom_channeled[_i]) return true;
    }
    return false;
};

get_doom_slot_x = function(slot) {
    var _total = MAX_DOOM_SLOTS * DC_W + (MAX_DOOM_SLOTS - 1) * DC_GAP;
    return (400 - _total / 2) + slot * (DC_W + DC_GAP);
};

get_hand_card_x = function(slot) {
    var _total_w = MAX_HAND * CARD_W + (MAX_HAND - 1) * 8;
    return (400 - _total_w / 2 + CARD_W / 2) + slot * (CARD_W + 8);
};

get_play_card_x = function(slot, total) {
    var _total_w = total * CARD_W + (total - 1) * 8;
    return (400 - _total_w / 2 + CARD_W / 2) + slot * (CARD_W + 8);
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
            if (!instance_exists(hand_cards[_j])) { _j--; continue; }
            var _va = 0;
            var _vb = 0;
            if (sort_mode == 0) { _va = hand_cards[_j].card_rank; _vb = _key.card_rank; }
            else                { _va = hand_cards[_j].card_suit;  _vb = _key.card_suit; }
            if (_va > _vb) { hand_cards[_j + 1] = hand_cards[_j]; _j--; }
            else break;
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

compute_score = function(cards_arr) {
    var _n = array_length(cards_arr);
    var _ranks = [];
    var _suits = [];
    for (var _i = 0; _i < _n; _i++) {
        _ranks[_i] = cards_arr[_i].card_rank;
        _suits[_i] = cards_arr[_i].card_suit;
    }

    var _hs;
    if (_n >= 5) { _hs = best_5_from_n(_ranks, _suits); }
    else         { _hs = eval_partial(_ranks, _suits, _n); }

    last_hand_type = _hs[0];

    if (forgotten_hand >= 0 && last_hand_type == forgotten_hand
            && doom_active(12) && !doom_channeled_id(12)) {
        last_hand_type = 0;
    }

    var _base  = hand_base_score(last_hand_type);
    var _chips = _base[0];
    var _mult  = _base[1];

    for (var _i = 0; _i < _n; _i++)
        _chips += card_chip_value(cards_arr[_i].card_rank);

    var _face_count = 0;
    for (var _i = 0; _i < _n; _i++) {
        var _r = cards_arr[_i].card_rank;
        if (_r >= 11 && _r <= 13) _face_count++;
    }

    if (doom_active(8)) {
        if (doom_channeled_id(8)) { _chips += _face_count * 60; }
        else                      { add_doom(_face_count); }
    }

    if (frozen_card_rank >= 0 && doom_active(2)) {
        var _frozen_in_play = false;
        for (var _i = 0; _i < _n; _i++) {
            if (cards_arr[_i].card_rank == frozen_card_rank
                    && cards_arr[_i].card_suit == frozen_card_suit) {
                _frozen_in_play = true;
                break;
            }
        }
        if (_frozen_in_play) {
            if (doom_channeled_id(2)) { _mult += 50; }
            else                      { add_doom(1); }
        }
    }

    if (last_hand_type == 5 && doom_active(3)) {
        if (doom_channeled_id(3)) { midnight_auto_win = true; }
        else                      { add_doom(3); }
    }

    if (doom_channeled_id(4) && _n > 3) { _chips += (_n - 3) * 30; }
    if (doom_channeled_id(5))            { _mult  += 10; }
    if (doom_channeled_id(6))            { _chips += 40; }
    if (doom_channeled_id(9))            { _chips += 200; }
    if (doom_channeled_id(13))           { _chips += 150; _mult += 8; }

    if (doom_channeled_id(0)) { _chips *= 3; }
    if (doom_channeled_id(12)) { _mult *= 2; }

    if (doom_channeled_id(14)) {
        _mult *= 2;
        mult_penalty = 0;
    } else if (doom_active(14)) {
        _mult = max(_mult - mult_penalty, 1);
    }

    last_chips = _chips;
    last_mult  = max(_mult, 1);
    last_score = last_chips * last_mult;

    if (midnight_auto_win) {
        round_score   = target_score;
        midnight_auto_win = false;
    } else {
        round_score += last_score;
    }
};

play_hand = function() {
    var _sel = get_selected();
    var _n   = array_length(_sel);
    if (_n == 0) return;

    if (doom_active(4) && !doom_channeled_id(4) && _n < 4) {
        add_doom(2);
    }

    play_count = _n;
    for (var _i = 0; _i < _n; _i++) {
        var _inst  = _sel[_i];
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

    if (doom_active(10) && !doom_channeled_id(10)) {
        if (round_score < target_score * 0.5) add_doom(1);
    }

    if (doom_active(14) && !doom_channeled_id(14)) {
        mult_penalty++;
    }

    if (doom_channeled_id(7)) {
        add_doom(1);
    } else {
        hands_left--;
    }

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

apply_ghost_hand_passive = function() {
    if (!doom_active(1)) return;
    var _hi = [];
    var _hc = 0;
    for (var _j = 0; _j < MAX_HAND; _j++) {
        if (instance_exists(hand_cards[_j])) { _hi[_hc] = _j; _hc++; }
    }
    if (_hc > 0) {
        var _pick = _hi[irandom(_hc - 1)];
        instance_destroy(hand_cards[_pick]);
        hand_cards[_pick] = noone;
    }
};

channel_doom_card = function(slot) {
    if (slot < 0 || slot >= MAX_DOOM_SLOTS) return;
    if (doom_channeled[slot]) return;
    if (doom_slots[slot] < 0) return;
    if (doom_inhibited[slot]) return;
    if (doom >= MAX_DOOM - 1) return;

    add_doom(2);
    doom_channeled[slot] = true;

    var _id = doom_slots[slot];
    if (_id == 1)  { hand_size_bonus += 4; }
    if (_id == 6)  { add_doom(-3); }
    if (_id == 9)  { if (doom > 5) doom = 5; }
    if (_id == 10) {
        round_score   = max(round_score, round(target_score * 0.6));
        display_score = round_score;
    }
    if (_id == 11) { jumpscare_protect = true; }
};

add_doom_card = function() {
    var _avail = [];
    var _ac    = 0;
    for (var _id = 0; _id < DOOM_CARD_COUNT; _id++) {
        var _found = false;
        for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
            if (doom_slots[_i] == _id) { _found = true; break; }
        }
        if (!_found) { _avail[_ac] = _id; _ac++; }
    }
    if (_ac == 0) return;
    _avail = shuffle_array(_avail);
    var _new = _avail[0];

    if (doom_count < MAX_DOOM_SLOTS) {
        for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
            if (doom_slots[_i] < 0) {
                doom_slots[_i]     = _new;
                doom_channeled[_i] = false;
                doom_inhibited[_i] = false;
                doom_count++;
                break;
            }
        }
    } else {
        var _rep = [];
        var _rc  = 0;
        for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
            if (!doom_inhibited[_i]) { _rep[_rc] = _i; _rc++; }
        }
        if (_rc > 0) {
            var _slot = _rep[irandom(_rc - 1)];
            doom_slots[_slot]     = _new;
            doom_channeled[_slot] = false;
        }
    }
};

apply_round_start_passives = function() {
    jumpscare_chance = 0.08;
    for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
        var _id = doom_slots[_i];
        if (_id < 0 || doom_inhibited[_i]) continue;
        if (_id == 0)  money       = max(money - 1, 0);
        if (_id == 5)  money       = max(money - 2, 0);
        if (_id == 7)  hands_left  = max(hands_left - 1, 1);
        if (_id == 11) jumpscare_chance += 0.4;
        if (_id == 12) forgotten_hand = irandom(8);
    }
};

apply_post_deal_passives = function() {
    for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
        var _id = doom_slots[_i];
        if (_id < 0 || doom_inhibited[_i]) continue;

        if (_id == 2) {
            var _hi = [];
            var _hc = 0;
            for (var _j = 0; _j < MAX_HAND; _j++) {
                if (instance_exists(hand_cards[_j])) { _hi[_hc] = _j; _hc++; }
            }
            if (_hc > 0) {
                var _pick    = _hi[irandom(_hc - 1)];
                frozen_card_rank = hand_cards[_pick].card_rank;
                frozen_card_suit = hand_cards[_pick].card_suit;
            }
        }

        if (_id == 6) {
            var _low_v = 999;
            var _low_s = -1;
            for (var _j = 0; _j < MAX_HAND; _j++) {
                if (instance_exists(hand_cards[_j]) && hand_cards[_j].card_rank < _low_v) {
                    _low_v = hand_cards[_j].card_rank;
                    _low_s = _j;
                }
            }
            if (_low_s >= 0) {
                sacrifice_rank = hand_cards[_low_s].card_rank;
                sacrifice_suit = hand_cards[_low_s].card_suit;
                instance_destroy(hand_cards[_low_s]);
                hand_cards[_low_s] = noone;
            }
        }
    }
    compact_hand();
};

setup_shop = function() {
    var _pool = array_create(SHOP_BOON_COUNT, 0);
    for (var _i = 0; _i < SHOP_BOON_COUNT; _i++) _pool[_i] = _i;
    _pool = shuffle_array(_pool);
    shop_offers[0] = _pool[0];
    shop_offers[1] = _pool[1];
};

init_round = function() {
    with (obj_card) instance_destroy();
    for (var _i = 0; _i < MAX_HAND; _i++) hand_cards[_i] = noone;
    for (var _i = 0; _i < MAX_PLAY; _i++) play_cards[_i] = noone;

    hands_left     = 4 + extra_hands;
    discards_left  = 3 + extra_discards;
    extra_hands    = 0;
    extra_discards = 0;
    round_score    = 0;
    play_count     = 0;
    target_score   = get_target();
    mult_penalty   = 0;
    midnight_auto_win = false;
    frozen_card_rank  = -1;
    frozen_card_suit  = -1;
    sacrifice_rank    = -1;
    sacrifice_suit    = -1;
    forgotten_hand    = -1;
    jumpscare_protect = false;
    last_hand_type    = -1;
    last_chips        = 0;
    last_mult         = 0;
    last_score        = 0;
    display_score     = 0;
    score_anim_timer  = 0;

    for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
        doom_channeled[_i] = false;
        doom_inhibited[_i] = false;
    }

    add_doom_card();
    apply_round_start_passives();
    rebuild_deck();
    deal_to_hand();
    apply_post_deal_passives();
};

full_reset = function() {
    ante              = 1;
    blind_idx         = 0;
    money             = 4;
    doom              = 0;
    hand_size_bonus   = 0;
    extra_hands       = 0;
    extra_discards    = 0;
    for (var _i = 0; _i < MAX_DOOM_SLOTS; _i++) {
        doom_slots[_i]     = -1;
        doom_channeled[_i] = false;
        doom_inhibited[_i] = false;
    }
    doom_count = 0;
};

doom_art = array_create(DOOM_CARD_COUNT, -1);
doom_art[0]  = spr_doom_card_art_0;
doom_art[1]  = spr_doom_card_art_1;
doom_art[2]  = spr_doom_card_art_2;
doom_art[3]  = spr_doom_card_art_3;
doom_art[4]  = spr_doom_card_art_4;
doom_art[5]  = spr_doom_card_art_5;
doom_art[6]  = spr_doom_card_art_6;
doom_art[7]  = spr_doom_card_art_7;
doom_art[8]  = spr_doom_card_art_8;
doom_art[9]  = spr_doom_card_art_9;
doom_art[10] = spr_doom_card_art_10;
doom_art[11] = spr_doom_card_art_11;
doom_art[12] = spr_doom_card_art_12;
doom_art[13] = spr_doom_card_art_13;
doom_art[14] = spr_doom_card_art_14;

var _bgm = audio_play_sound(snd_bgm, 0, true);
audio_sound_gain(_bgm, 0.15, 0);
