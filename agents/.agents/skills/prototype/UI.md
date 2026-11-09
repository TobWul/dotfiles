# UI Prototype

Design **several radically different variants** of a screen in Paper, side by side, so the user can compare them, pick one (or steal bits from each), and archive the rest.

If the question is about logic or state rather than what something looks like, use [LOGIC.md](LOGIC.md).

## Process

### 1. Load the tools

1. Load the Paper guide: `get_guide({ topic: "paper-mcp-instructions" })`, and follow it for the rest of the work.
2. If a UI design skill is listed for this project or organisation, call the Skill tool for it. Its steps and rules govern every variant.
3. Call `get_basic_info` on the file the user has open, and `get_tokens` to see the tokens and components its design system has. If no open file fits the prototype, ask which file to use.

Done when the guide (and the UI design skill, if any) is loaded and you know the file's tokens.

### 2. State the question and pick N

Default to **3 variants**, capped at 5; past that they stop being radically different and become noise.

Create a new page named `Prototype: <question>`. Put a text note at its top: the question, the variants, and that this is a prototype, e.g.

> "Prototype: how should a user register a new mast? Three variants: A full page per topic, B side panel over the map, C stepwise dialog."

### 3. Design the variants

Run the UI design skill's steps once for the screen, if there is one, then design each variant on its own artboard, laid out left to right and named `A: <idea>`, `B: <idea>`, and so on.

Variants must be **structurally different**: a different container (dialog, side panel, full page), layout, information hierarchy or primary affordance. Three tweaked versions of one layout are wallpaper, not a prototype. If two come out alike, redo one with an explicit constraint that rules out the other's structure.

Every variant obeys the design system's rules; only structure varies. Done when each variant passes the UI design skill's check step (or the design system's conventions, without one), with any deviation noted beside its artboard.

### 4. Hand it over

Tell the user the page name and give a one-line summary of each variant's idea. The interesting feedback is usually **"the header from B with the panel from C"**, which is the design they actually want. Combine it into a new variant on the same page rather than editing the originals, so the comparison survives.

### 5. Capture the answer

Once a variant wins, record which one and why on the implementation issue, with a link to the prototype page. Move the winner to the app's real design pages; leave the prototype page as the primary source, archived rather than deleted.

## Anti-patterns

- **Variants that differ only in colour or copy.** That's a tweak. Real variants disagree about structure.
- **Promoting the prototype directly into code.** The variants were drawn under prototype constraints. Build the winner properly from the design system's components.
