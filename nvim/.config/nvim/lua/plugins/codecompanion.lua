return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				display = {
					show_header_separator = false,
				},
				strategies = {
					chat = {
						adapter = "anthropic",
					},
					inline = {
						adapter = "anthropic",
					},
				},
				adapters = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "cmd:op read op://personal/LLM/credential --no-newline",
							},
						})
					end,
					deepseek = function()
						return require("codecompanion.adapters").extend("ollama", {
							name = "deepseek-r1",
							schema = {
								model = {
									default = "deepseek-r1:7b",
								},
								num_ctx = {
									default = 16384,
								},
								num_predict = {
									default = -1,
								},
							},
						})
					end,
				},
				prompt_library = {
					["JSDocs"] = {
						strategy = "chat",
						description = "Generate comprehensive JSDoc documentation for React components written in Typescript",
						opts = {
							short_name = "jsdoc",
							auto_submit = true,
						},
						prompts = {
							{
								role = "system",
								content = [[You are a technical writer specializing in React design systems with knowledge about code and UX. 
Your task is to generate comprehensive JSDoc documentation that follows these rules:
- Write a very brief sentence about what this component is.
- Write about recommendations for usage with a focus on helping developers think about UX.
- Include @example with common usage patterns
- Add @link to Storybook documentation
- Add @link to Figma documentation
- Document every prop in the Typescript type. Often in the format of "type ComponentProps = {}"
- Write everything in norwegian, but keep parameters in the original language.

Here is an example:

/**
 * En Table-komponent som viser data i tabellformat.
 * 
 * @description
 * Bruk denne komponenten når du har en liste med data som du ønsker å vise til brukeren. Tabeller egner seg godt til å sammenligne elementer på tvers av rader og kolonner.
 * 
 * @remarks
 * Anbefalinger for bruk:
 * - Bruk de forskjellige kolonnetypene for å vise dataene på mest hensiktsmessig måte.
 * - Velg kun de viktigste dataene som skal vises i tabellen. For ytterligere data,
 *   vurder å åpne opp en detaljvisning.
 * - Velg et begrenset antall felter å filtrere på. Fokuser på de viktigste
 *   feltene som brukerne sannsynligvis vil ønske å filtrere på.
 * 
 * @component
 * @param {TableProps} props - Komponentens props
 * @param {string} props.title - Tittelteksten som vises i tabellhodet
 * @param {string} [props.className] - Ekstra CSS-klasser som skal anvendes på tabellen. Gjelder for den omkringliggende <table>-taggen.
 * @param {string} [as] - Override av taggen som brukes til å rendre den omkringliggende <Box>-taggen. Standard er "table"
 * @param [...rest] - Alle andre props videresendes til <table>-taggen
 * @param {React.ReactNode} props.children - Innholdet som skal vises når accordion er utvidet
 * 
 * @see [Storybook](https://komponenter.ren.no/Table)
 * @see [Figma](https://www.figma.com/design/B5ErWqVWt0dK3q1r6zaGVh/%F0%9F%93%90-REN-Designsystem?node-id=18-476&t=H8GqUUikc9BSLD6Y-11)
 */
]],
							},
							{
								role = "user",
								content = function(context)
									local text = require("codecompanion.helpers.actions").get_code(
										context.start_line,
										context.end_line
									)

									return "Generate JSDoc documentation for this React component:\n\n```"
										.. context.filetype
										.. "\n"
										.. text
										.. "\n```"
								end,
								opts = {
									contains_code = true,
								},
							},
						},
					},
					["Code Expert"] = {
						strategy = "chat",
						description = "Get some special advice from an LLM",
						opts = {
							mapping = "<LocalLeader>ape",
							modes = { "v" },
							short_name = "expert",
							auto_submit = true,
							stop_context_insertion = true,
							user_prompt = true,
						},
						prompts = {
							{
								role = "system",
								content = function(context)
									return "I want you to act as a senior "
										.. context.filetype
										.. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
								end,
							},
							{
								role = "user",
								content = function(context)
									local text = require("codecompanion.helpers.actions").get_code(
										context.start_line,
										context.end_line
									)

									return "I have the following code:\n\n```"
										.. context.filetype
										.. "\n"
										.. text
										.. "\n```\n\n"
								end,
								opts = {
									contains_code = true,
								},
							},
						},
					},
					["Component testing"] = {
						strategy = "chat",
						description = "Write tests for components in @ren-no/design-system",
						opts = {
							short_name = "component-testing",
							auto_submit = true,
						},
						prompts = {
							{
								role = "system",
								content = [[
                  Use this documentation to complete the task:
## Tester

### Kjøre tester

- `npm test` - kjører testene i Chromium, Firefox og Webkit i headless mode. Etter at alle tester er kjørt så starter watch mode og relevante tester kjøres på nytt når der endringer i filer som er under test.
- `npm test:browser` - lar deg velge nettleser, og du kan se testresultatet i nettleseren som åpnes. Også denne går i watch mode etter alle tester er kjørt.

### Skrive tester

Testmiljøet er konfigurert med Vitest og Vitest browser. Miljøet har alt du trenger fra å skrive unit tester til å teste React komponenter i nettleser. Testene kjøres i ekte nettlesere: Chromium, Firefox og Webkit. Du finner lenke til dokumentasjon her under:

- [Vitest](https://vitest.dev)
- [Vitest Browser](https://vitest.dev/guide/browser/)
  - [Vitest Browser React](https://github.com/vitest-dev/vitest-browser-react)
  - [Playwright](https://playwright.dev)

#### En unit test i sin enkleste form

`sum.tsx`

```tsx
export function sum(a: number, b: number) {
  return a + b;
}
```

`sum.test.tsx`

```tsx
import { expect, test } from "vitest";

import { sum } from "./sum";

test("sum adds 1 + 2 to equal 3", () => {
  expect(sum(1, 2)).toBe(3);
});
```

Resultat av `npm test`:

```sh
✓  Firefox  lib/testing.test.tsx (1 test) 1ms
    ✓ sum adds 1 + 2 to equal 3
✓  Chromium/Chrome/Brave  lib/testing.test.tsx (1 test) 0ms
    ✓ sum adds 1 + 2 to equal 3
✓  WebKit/Safari  lib/testing.test.tsx (1 test) 1ms
    ✓ sum adds 1 + 2 to equal 3

Test Files  3 passed (3)
     Tests  3 passed (3)
  Start at  14:22:30
  Duration  14ms
```

**Merk**: Unit tester trenger ikke å kjøres i hver enkelt nettleser, men som eksempelet viser så kan kan de fint kjøres i testmiljøet selv om det er konfigurert med Browser Mode.

Se Vitest sin dokumentasjon for alle måter [expect](https://vitest.dev/api/expect.html), [Mock functions](https://vitest.dev/api/mock.html), [Test API (describe, test)](https://vitest.dev/api/) mm. kan brukes i testene.

#### Test av React komponenter

Komponentene rendres i nettleseren. Så her må du inkludere det komponenten trenger (feks ContextProvider) for å fungere i render-funksjonen.

Etter komponenten er rendret så kan du teste den med `page`, `userEvent` og `server` fra `@vitest/browser/context`.

- [page](https://vitest.dev/guide/browser/context.html#page) - eksponerer verktøy fra Playwright, det er ikke alt som er tilgjengelig
- [userEvent](https://vitest.dev/guide/browser/interactivity-api.html) - brukes på samme måte som `@testing-library/user-event`, men i stedet for et kunstig DOM (JSDOM) så brukes nettleserens apier
- [server](https://vitest.dev/guide/browser/context.html#server) - representerer Node.js mijøet der testen kjører

##### Nyttig dokumentasjon

- [Locators](https://vitest.dev/guide/browser/locators.html) - Finne elementer på siden
- [Interactivity](https://vitest.dev/guide/browser/interactivity-api.html) - Bruker input. F.eks klikk, skrive tekst, dra og slipp, laste opp, hover, mm.
- [Commands](https://vitest.dev/guide/browser/commands.html) - Kjører en funksjon på server og sender resultatet til nettleseren, f.eks filopplasting
- [Assertions](https://vitest.dev/guide/browser/assertion-api.html) - Lar deg bekrefte at ting er som det skal. Samme som er tilgjengelig via `@testing-library/jest-dom`

##### Eksempel med kommentarer

`TestKomponent.test.tsx`

```tsx
import { expect, test, describe, vi, beforeEach, afterEach } from "vitest";
import { render } from "vitest-browser-react";
import { page } from "@vitest/browser/context";

// Importer komponenten eller javascript funksjonen som skal testes
import { TestKomponent } from "./TestKomponent";

// Gruppér i relaterte tester describe blokker
describe("TestKomponent" => {
  beforeEach(() => {
    // Oppsett før hver test
    // - Reset av mocks
    // - Cleanup av komponent
  });

  afterEach(() => {
    // Rydding etter hver test
    // - Reset av mocks
    // - Cleanup av komponent
  });

  // Beskriv hva testen gjør, vises i en liste med testresultat
  test("viser en knapp som kan klikkes", async() => {
    // Bruker en testfunksjon/mock fra Vitest for å teste onClick
    const onClick = vi.fn();

    // Putt komponenten som skal testes i DOMen
    render(<TestKomponent onClick={onClick} />);

    // Finn knappen på siden
    const button = page.getByRole("button");

    // Bekreft at knappen er der
    await expect.element(button).toBeInDocument();

    // Gjør operasjoner som simulerer kompnenten i bruk
    await button.click();
    await button.click();

    // Bekreft at operasjonene ble utført
    expect(onClick).toHaveBeenCalledTimes(2);
  });
});
```

#### Test av hooks

[Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks) er en smart måte å dele eller samle funksjonalitet i React. Slik skrives tester:

`useExampleHook.test.tsx`

```tsx
import { renderHook } from "vitest-browser-react";
import { expect, test, describe, vi, beforeEach } from "vitest";
import React, { act } from "react";
import { useExampleHook } from "./useExampleHook";

describe("useExampleHook" => {
  test("useExampleHook can do something", () => {
    // Initialiser hook en
    const { result } = renderHook(() => useExampleHook(props));

    // Bruk hooken slik du ville brukt den i en komponent
    act(() => {
      result.current.doSomething(props);
    });

    // Bekreft at operasjonen var vellykket
    expect(result.somethingHappened).toEqual(true);
  });
});
```

#### Tips og triks

[Eksempel fra Multiselect](https://github.com/ren-no/ren-design-system/blob/f9abdd40236740fda64ea614dfd268716f032bcf/lib/components/Multiselect/Multiselect.test.tsx#L49): Om du har et element og vil klikke på en knapp inni elementet, så kan den nås på denne måten:

```html
<span>1000<button>Fjern</button></span>
```

```tsx
const tag = page.getByText("1000Fjern");
const removeButton = tag.element().querySelector("button");

await removeButton?.click();
```
                ]],
							},
							{
								role = "user",
								content = function(context)
									local text = require("codecompanion.helpers.actions").get_code(
										context.start_line,
										context.end_line
									)

									return "Write tests for this code:\n\n```"
										.. context.filetype
										.. "\n"
										.. text
										.. "\n```"
								end,
								opts = {
									contains_code = true,
								},
							},
						},
					},
				},
			})
			local wk = require("which-key")
			wk.add({
				{ "<leader>a", group = "AI" },
				{ "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "Open AI Chat" },
				{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "Open AI Chat" },
				{
					"<leader>ac",
					"<cmd>CodeCompanionChat Add<CR>",
					desc = "Open AI Chat with visally selected text",
					mode = "v",
				},
				{ "<leader>apd", "<cmd>CodeCompanion /jsdoc<CR>", desc = "JSDoc React component", mode = "v" },
			})
		end,
	},
}
