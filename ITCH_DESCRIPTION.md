# How to Play

Texas Hold'em Poker vs NPC. Both players start with 500 chips.

Each hand, you and the NPC are each dealt 2 hole cards. Then 5 community cards are revealed in stages — Flop (3), Turn (1), River (1). Between each stage, a round of betting takes place.

**Your actions:**
- FOLD— give up the hand, NPC wins the pot
- CHECK / CALL — match the current bet (or pass if no bet)
- RAISE — increase the bet by 20

Best 5-card hand from your 2 hole cards + 5 community cards wins the pot. Standard hand rankings apply (Pair → Two Pair → Three of a Kind → Straight → Flush → Full House → Four of a Kind → Straight Flush).

The game loops indefinitely. If either player hits 0 chips, the game ends — click to restart.



# Goals & Evaluation

Goal: I wanr to mod the original Rock-Paper-Scissors card clone into a fully playable Texas Hold'em poker game with betting, hand evaluation, and NPC AI.

The core mechanics — 4-round betting (Pre-Flop / Flop / Turn / River), blind structure, pot management, and complete 7-card hand evaluation — all work as intended. The NPC uses a rule-based pre-flop strategy combined with real-time hand strength evaluation post-flop, with a 20% bluff chance to keep gameplay unpredictable.

The main area that fell short of the original vision is polish: card sprites are placeholder programmatic drawings (to be replaced), and sound effects are temporary. The NPC AI, while functional, is relatively simple and could be improved with more nuanced bet sizing and positional awareness. Overall the mod successfully transforms the game into a meaningfully different experience with significantly more strategic depth than the original clone.
