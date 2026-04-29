# Retrospective

## How well did I clone the original?

Pretty close. The core loop — dealing cards one by one, AI picking a card, player hovering and clicking, revealing the result, collecting cards to the discard pile, and reshuffling when the deck runs out — all works as intended. The sprite art, card sizing, and green felt background match the visual style of the original. Sound effects fire on every card movement, selection, win, and loss.

## Issues I faced

The biggest headache was GameMaker's version compatibility. External `.yy` file edits had to exactly match the IDE version's expected JSON schema — wrong field names or versions caused the project to refuse to load entirely. A room Background layer was silently painting over everything every frame, which hid the deck and discard pile visuals for a long time before I found the cause. Getting the card collection order, flip timing (waiting for the player's card to arrive before revealing the AI card), and incremental discard pile updates to all feel smooth took several iterations.

## What I learned

State machines are the right tool for turn-based card games — having explicit phases (DEALING, AI_MOVE, PLAYER, REVEAL, CLEANUP, RESHUFFLE) made the logic easy to reason about and extend. I also learned that small visual details (one-by-one card animation, immediate face-flip on collect, stacking offset direction) make a huge difference in how polished the game feels compared to batch operations that cause jarring visual jumps.
