---
name: all-in-one-testing
description: Comprehensive all-in-one testing strategy and test suite patterns covering Smoke, Unit, Integration, End-to-End (E2E with Playwright), and Regression testing with Page Object Models, zero-flake fixtures, and CI/CD pipelines.
metadata:
  origin: Antigravity
---

# All-In-One Testing Strategy & Test Suites

A production-grade, multi-tiered testing blueprint covering the entire testing pyramid: **Smoke**, **Unit**, **Integration**, **End-to-End (E2E)**, and **Regression** testing.

---

## 1. The Full-Stack Testing Pyramid

```
           / \
          /   \
         / E2E \         -> Playwright (Real browser user journeys, Headed/Slow-Mo)
        /-------\
       / Integr. \       -> API routes, database schemas, webhooks, auth contexts
      /-----------\
     /    Unit     \     -> Vitest/Jest (Pure logic, calculations, transformers)
    /---------------\
   /     Smoke       \   -> Boot sanity checks, build verification, route 200s
  /-------------------\
```

| Layer | Primary Tool | Target | Execution Speed |
| :--- | :--- | :--- | :--- |
| **Smoke** | `curl`, lightweight spec | App boots, core routes return 200, env valid | ⚡ 1–3s |
| **Unit** | `vitest run` / `jest` | Pure utility functions, state logic, formatters | ⚡ < 100ms |
| **Integration** | `vitest run` (mocked DB/APIs) | API endpoints, webhooks, DB repositories, auth | ⏱️ 1–5s |
| **E2E** | `@playwright/test` | Real browser user journeys, clicks, forms, routes | 🐢 10–30s |
| **Regression** | Composite suite | Continuous verification across all layers | 🔄 Every PR/commit |

---

## 2. Directory & File Organization

```
project-root/
├── tests/
│   ├── fixtures/
│   │   ├── mock-routes.ts          # Network interceptors for auth & API mocks
│   │   ├── auth-state.json         # Storage state / cookies for authed journeys
│   │   └── seed-data.ts            # Deterministic fixtures
│   ├── e2e/
│   │   ├── pages/                  # Page Object Model (POM) layer
│   │   │   ├── BasePage.ts
│   │   │   ├── DashboardPage.ts
│   │   │   └── FeaturePage.ts
│   │   ├── smoke.spec.ts           # Instant boot & navigation sanity checks
│   │   ├── auth.spec.ts            # Login, signup, session recovery
│   │   └── features.spec.ts        # Core business user flows
│   └── integration/
│       ├── api.test.ts             # REST/RPC endpoint tests
│       └── webhooks.test.ts        # Inbound webhook parsing & crypto sign tests
├── src/
│   └── **/*.test.ts                # Colocated unit tests next to source files
├── playwright.config.ts            # E2E test runner configuration
└── vitest.config.ts                # Unit/Integration runner configuration
```

---

## 3. Layer-by-Layer Implementation Recipes

### A. Smoke Testing (`tests/e2e/smoke.spec.ts`)
Validates that the app compiles, loads assets, and core navigation routes respond with status 200 without white-screens or unhandled console errors.

```typescript
import { test, expect } from '@playwright/test';

test.describe('Smoke Test Suite', () => {
  const routes = ['/dashboard', '/inbox', '/contacts', '/settings'];

  for (const route of routes) {
    test(`should load ${route} without crash`, async ({ page }) => {
      const response = await page.goto(route);
      expect(response?.status()).toBeLessThan(400);
      await expect(page.locator('main, [role="main"]').first()).toBeVisible();
    });
  }
});
```

---

### B. Unit Testing (`src/lib/**/*.test.ts`)
Tests functions and utilities in complete isolation.

```typescript
import { describe, it, expect } from 'vitest';
import { formatCurrency, calculateDiscount } from './pricing';

describe('Pricing Utilities', () => {
  it('formats currency correctly with standard locales', () => {
    expect(formatCurrency(1250, 'USD')).toBe('$1,250.00');
    expect(formatCurrency(0, 'USD')).toBe('$0.00');
  });

  it('calculates tiered discount percentage correctly', () => {
    expect(calculateDiscount(1000, 15)).toBe(850);
  });
});
```

---

### C. Integration Testing (`src/app/api/**/*.test.ts`)
Verifies API handlers, webhook signatures, and data transformations.

```typescript
import { describe, it, expect, vi } from 'vitest';
import { POST } from './route';
import { NextRequest } from 'next/server';

describe('Webhook Inbound Handler', () => {
  it('rejects unsigned payloads with 401', async () => {
    const req = new NextRequest('http://localhost:3000/api/webhook', {
      method: 'POST',
      body: JSON.stringify({ event: 'test' }),
    });

    const res = await POST(req);
    expect(res.status).toBe(401);
  });
});
```

---

### D. End-to-End (E2E) Testing with Page Object Model

#### 1. Page Object Model (`tests/e2e/pages/FeaturePage.ts`)
```typescript
import { type Page, type Locator, expect } from '@playwright/test';

export class FeaturePage {
  readonly page: Page;
  readonly searchInput: Locator;
  readonly submitButton: Locator;
  readonly resultCards: Locator;

  constructor(page: Page) {
    this.page = page;
    this.searchInput = page.getByPlaceholder(/Search/i);
    this.submitButton = page.getByRole('button', { name: /Submit|Create/i });
    this.resultCards = page.locator('[data-testid="item-card"]');
  }

  async goto() {
    await this.page.goto('/features');
    await this.searchInput.waitFor({ state: 'visible' });
  }

  async search(term: string) {
    await this.searchInput.fill(term);
    await this.page.waitForTimeout(150); // Debounce settle
  }
}
```

#### 2. E2E Spec (`tests/e2e/features.spec.ts`)
```typescript
import { test, expect } from '@playwright/test';
import { FeaturePage } from './pages/FeaturePage';
import { setupE2ERoutes } from '../fixtures/mock-routes';

test.describe('Feature Workflows E2E', () => {
  test.beforeEach(async ({ page }) => {
    await setupE2ERoutes(page);
  });

  test('user can search and inspect items', async ({ page }) => {
    const featurePage = new FeaturePage(page);
    await featurePage.goto();

    await featurePage.search('Checkout');
    await expect(featurePage.resultCards.first()).toContainText(/Checkout/i);
  });
});
```

---

## 4. Playwright Configuration (`playwright.config.ts`)

```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: [
    ['html', { outputFolder: 'playwright-report', open: 'never' }],
    ['list'],
  ],
  use: {
    baseURL: process.env.BASE_URL || 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    actionTimeout: 15000,
    navigationTimeout: 30000,
    launchOptions: {
      slowMo: process.env.SLOWMO ? parseInt(process.env.SLOWMO, 10) : (process.env.CI ? 0 : 500),
    },
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: true,
    timeout: 120000,
  },
});
```

---

## 5. Execution Modes & Scripts (`package.json`)

Add these standardized test commands:

```json
{
  "scripts": {
    "test": "vitest run",
    "test:watch": "vitest",
    "test:smoke": "playwright test tests/e2e/smoke.spec.ts",
    "test:e2e": "playwright test",
    "test:e2e:headed": "playwright test --headed",
    "test:e2e:slow": "SLOWMO=1000 playwright test --headed",
    "test:e2e:ui": "playwright test --ui",
    "verify:all": "npm run lint && npm run typecheck && npm run test && npm run test:e2e"
  }
}
```

---

## 6. Zero-Flakiness Rules

1. **Auto-Waiting Locators**: Always use `page.getByRole()`, `page.getByPlaceholder()`, or `page.locator('[data-testid="..."]')`. Never use arbitrary `sleep(5000)`.
2. **Explicit Readiness**: Wait for key parent elements (`await heading.waitFor({ state: 'visible' })`) before asserting count or content.
3. **Deterministic Mocks**: Intercept external network calls in E2E fixtures using `page.route()` to avoid external third-party downtime.
4. **Isolated Test Data**: Every test should generate its own unique test entity IDs or rely on clean fixtures.

---

## 7. Pre-Merge Verification Checklist

Before pushing code or deploying:
1. `npm run lint` $\to$ **0 errors, 0 warnings**
2. `npm run typecheck` $\to$ **0 type errors**
3. `npm run test` $\to$ **All unit/integration suites pass**
4. `npm run test:e2e` $\to$ **All end-to-end user journeys pass**
