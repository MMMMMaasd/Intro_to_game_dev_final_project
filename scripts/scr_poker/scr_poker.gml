function eval_5card(r5, s5) {
    var r = [r5[0], r5[1], r5[2], r5[3], r5[4]];
    for (var i = 0; i < 4; i++)
        for (var j = 0; j < 4 - i; j++)
            if (r[j] < r[j+1]) { var t = r[j]; r[j] = r[j+1]; r[j+1] = t; }

    var flush = (s5[0]==s5[1] && s5[1]==s5[2] && s5[2]==s5[3] && s5[3]==s5[4]);
    var str = (r[0]-r[1]==1 && r[1]-r[2]==1 && r[2]-r[3]==1 && r[3]-r[4]==1);
    var str_hi = r[0];
    if (r[0]==14 && r[1]==5 && r[2]==4 && r[3]==3 && r[4]==2) { str=true; str_hi=5; }

    var cnt = array_create(15, 0);
    for (var i = 0; i < 5; i++) cnt[r[i]]++;

    var four=-1, three=-1, p1=-1, p2=-1;
    for (var rv = 14; rv >= 2; rv--) {
        if (cnt[rv]==4) four=rv;
        else if (cnt[rv]==3) three=rv;
        else if (cnt[rv]==2) { if (p1==-1) p1=rv; else p2=rv; }
    }

    if (flush && str) return [8, str_hi, 0,0,0,0];
    if (four != -1) {
        var k=0; for (var rv=14;rv>=2;rv--) if (rv!=four&&cnt[rv]>0){k=rv;break;}
        return [7, four, k, 0,0,0];
    }
    if (three!=-1 && p1!=-1) return [6, three, p1, 0,0,0];
    if (flush) return [5, r[0],r[1],r[2],r[3],r[4]];
    if (str) return [4, str_hi, 0,0,0,0];
    if (three != -1) {
        var k0=0, k1=0, ki=0;
        for (var rv=14;rv>=2;rv--) if (rv!=three&&cnt[rv]>0) { if(ki==0)k0=rv;else k1=rv; ki++; }
        return [3, three, k0, k1, 0,0];
    }
    if (p2 != -1) {
        var k=0; for (var rv=14;rv>=2;rv--) if (rv!=p1&&rv!=p2&&cnt[rv]>0){k=rv;break;}
        return [2, p1, p2, k, 0,0];
    }
    if (p1 != -1) {
        var k0=0, k1=0, k2=0, ki=0;
        for (var rv=14;rv>=2;rv--) if (rv!=p1&&cnt[rv]>0) { if(ki==0)k0=rv;else if(ki==1)k1=rv;else k2=rv; ki++; }
        return [1, p1, k0, k1, k2, 0];
    }
    return [0, r[0],r[1],r[2],r[3],r[4]];
}

function cmp_hand(a, b) {
    for (var i = 0; i < 6; i++) {
        if (a[i] > b[i]) return 1;
        if (a[i] < b[i]) return -1;
    }
    return 0;
}

function best_5_from_n(ranks, suits) {
    var n = array_length(ranks);
    if (n < 5) return [0,0,0,0,0,0];
    var best = [-1,0,0,0,0,0];
    for (var a=0; a<n-4; a++)
    for (var b=a+1; b<n-3; b++)
    for (var c=b+1; c<n-2; c++)
    for (var d=c+1; d<n-1; d++)
    for (var e=d+1; e<n;   e++) {
        var r5 = [ranks[a], ranks[b], ranks[c], ranks[d], ranks[e]];
        var s5 = [suits[a], suits[b], suits[c], suits[d], suits[e]];
        var sc = eval_5card(r5, s5);
        if (cmp_hand(sc, best) > 0) best = sc;
    }
    return best;
}

function hand_name(score) {
    switch (score[0]) {
        case 8: return "Straight Flush!";
        case 7: return "Four of a Kind!";
        case 6: return "Full House!";
        case 5: return "Flush!";
        case 4: return "Straight!";
        case 3: return "Three of a Kind";
        case 2: return "Two Pair";
        case 1: return "Pair";
        default: return "High Card";
    }
}


function hand_base_score(hand_type) {
    switch (hand_type) {
        case 0: return [5,   1];
        case 1: return [10,  2];
        case 2: return [20,  2];
        case 3: return [30,  3];
        case 4: return [30,  4];
        case 5: return [35,  4];
        case 6: return [40,  4];
        case 7: return [60,  7];
        case 8: return [100, 8];
        default: return [5,  1];
    }
}

function card_chip_value(rank) {
    if (rank >= 2 && rank <= 9) return rank;
    if (rank == 14) return 11;
    return 10;
}

function hand_type_name(ht) {
    switch (ht) {
        case 0: return "High Card";
        case 1: return "Pair";
        case 2: return "Two Pair";
        case 3: return "Three of a Kind";
        case 4: return "Straight";
        case 5: return "Flush";
        case 6: return "Full House";
        case 7: return "Four of a Kind";
        case 8: return "Straight Flush";
        default: return "";
    }
}

function shuffle_array(arr) {
    var _n = array_length(arr);
    for (var _i = _n - 1; _i > 0; _i--) {
        var _j = irandom(_i);
        var _tmp = arr[_i];
        arr[_i] = arr[_j];
        arr[_j] = _tmp;
    }
    return arr;
}

function rank_display(rank) {
    switch (rank) {
        case 11: return "J";
        case 12: return "Q";
        case 13: return "K";
        case 14: return "A";
        default: return string(rank);
    }
}

function suit_display(suit) {
    switch (suit) {
        case 0: return "Spades";
        case 1: return "Hearts";
        case 2: return "Diamonds";
        default: return "Clubs";
    }
}

function get_card_sprite(rank, suit) {
    switch (rank) {
        case 2:
            if (suit == 0) return spr_card_2s;
            if (suit == 1) return spr_card_2d;
            if (suit == 2) return spr_card_2h;
            return spr_card_2c;
        case 3:
            if (suit == 0) return spr_card_3s;
            if (suit == 1) return spr_card_3d;
            if (suit == 2) return spr_card_3h;
            return spr_card_3c;
        case 4:
            if (suit == 0) return spr_card_4s;
            if (suit == 1) return spr_card_4d;
            if (suit == 2) return spr_card_4h;
            return spr_card_4c;
        case 5:
            if (suit == 0) return spr_card_5s;
            if (suit == 1) return spr_card_5d;
            if (suit == 2) return spr_card_5h;
            return spr_card_5c;
        case 6:
            if (suit == 0) return spr_card_6s;
            if (suit == 1) return spr_card_6d;
            if (suit == 2) return spr_card_6h;
            return spr_card_6c;
        case 7:
            if (suit == 0) return spr_card_7s;
            if (suit == 1) return spr_card_7d;
            if (suit == 2) return spr_card_7h;
            return spr_card_7c;
        case 8:
            if (suit == 0) return spr_card_8s;
            if (suit == 1) return spr_card_8d;
            if (suit == 2) return spr_card_8h;
            return spr_card_8c;
        case 9:
            if (suit == 0) return spr_card_9s;
            if (suit == 1) return spr_card_9d;
            if (suit == 2) return spr_card_9h;
            return spr_card_9c;
        case 10:
            if (suit == 0) return spr_card_10s;
            if (suit == 1) return spr_card_10d;
            if (suit == 2) return spr_card_10h;
            return spr_card_10c;
        case 11:
            if (suit == 0) return spr_card_js;
            if (suit == 1) return spr_card_jd;
            if (suit == 2) return spr_card_jh;
            return spr_card_jc;
        case 12:
            if (suit == 0) return spr_card_qs;
            if (suit == 1) return spr_card_qd;
            if (suit == 2) return spr_card_qh;
            return spr_card_qc;
        case 13:
            if (suit == 0) return spr_card_ks;
            if (suit == 1) return spr_card_kd;
            if (suit == 2) return spr_card_kh;
            return spr_card_kc;
        case 14:
            if (suit == 0) return spr_card_as;
            if (suit == 1) return spr_card_ad;
            if (suit == 2) return spr_card_ah;
            return spr_card_ac;
    }
    return spr_card_back;
}
