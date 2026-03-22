# OptiZenqor Restaurant

Flutter app for a branch-based restaurant brand experience built with GetX. The project currently uses a mock service layer, but the app structure is ready to be connected to real APIs, real maps, and production persistence later.

## Project Summary

This app is designed around `OptiZenqor_restaurant` and its branch network rather than a generic marketplace model.

Current product experience includes:

- Auth flow screens
- Home screen with auto-moving promo slider
- Home-only inline search with suggestions
- Branch-aware restaurant cards and detail screens
- Branch discovery map section
- Food category filters
- Popular food section
- Cart and checkout flow
- Orders with `Active`, `Past`, and `Cancelled`
- Notifications with swipe-to-delete
- Favorites, profile, addresses, payment methods, settings, legal, and support

The app is fully powered by local mock data today.

## Tech Stack

- Flutter
- Dart
- GetX for state management, dependency injection, and routing
- Google Fonts
- Material 3 UI

## App Entry

The app starts from [lib/main.dart](lib/main.dart), which launches `RestaurantApp`.

`RestaurantApp` is defined in [lib/app.dart](lib/app.dart) and configures:

- `GetMaterialApp`
- app themes
- initial bindings
- named routes
- initial route

## Dependency Injection

Global controllers and services are registered in [lib/app/bindings/initial_binding.dart](lib/app/bindings/initial_binding.dart).

Registered singletons include:

- `MockApiService`
- `AuthController`
- `MainNavController`
- `HomeController`
- `RestaurantController`
- `SearchController`
- `CartController`
- `CheckoutController`
- `OrdersController`
- `FavoritesController`
- `NotificationsController`
- `ProfileController`
- `SettingsController`

This means most screens use shared app state through GetX instead of creating isolated local state for every feature.

## Route Map

Named routes are declared in [lib/routes/app_routes.dart](lib/routes/app_routes.dart) and mapped in [lib/routes/app_pages.dart](lib/routes/app_pages.dart).

Main routes:

- `/` splash
- `/onboarding`
- `/login`
- `/signup`
- `/forgot-password`
- `/otp-verification`
- `/main-nav`
- `/search`
- `/restaurants`
- `/restaurant-detail`
- `/cart`
- `/checkout`
- `/order-success`
- `/order-tracking`
- `/order-detail`
- `/notifications`
- `/reviews`
- `/edit-profile`
- `/addresses`
- `/payment-methods`
- `/help-support`
- `/legal`
- `/settings`

## Folder Structure

```text
lib/
├── app/
│   ├── bindings/
│   └── theme/
├── core/
│   ├── constants/
│   ├── data/
│   ├── models/
│   ├── services/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── cart/
│   ├── checkout/
│   ├── favorites/
│   ├── home/
│   ├── main_nav/
│   ├── notifications/
│   ├── orders/
│   ├── profile/
│   ├── restaurants/
│   ├── search/
│   └── settings/
├── routes/
├── app.dart
└── main.dart
```

## Core Architecture

### 1. Mock Data Layer

All sample data is defined in [lib/core/data/mock_data.dart](lib/core/data/mock_data.dart).

This includes:

- food categories
- restaurant brands
- restaurant branches
- food items
- reviews
- addresses
- payment methods
- notifications
- orders
- profile data
- recent searches
- trending searches
- promo messages

### 2. Service Layer

[lib/core/services/mock_api_service.dart](lib/core/services/mock_api_service.dart) acts like a fake backend and returns mock data with a short delay.

This is the main replacement point for real backend integration later.

### 3. Models

Important domain models live in `lib/core/models`.

Examples:

- [restaurant.dart](lib/core/models/restaurant.dart)
- [food_item.dart](lib/core/models/food_item.dart)
- [order.dart](lib/core/models/order.dart)
- [address.dart](lib/core/models/address.dart)
- [payment_method.dart](lib/core/models/payment_method.dart)
- [notification_item.dart](lib/core/models/notification_item.dart)

### 4. Feature Controllers

Each major feature uses a GetX controller to own UI state and business logic.

Examples:

- [home_controller.dart](lib/features/home/controller/home_controller.dart)
- [restaurant_controller.dart](lib/features/restaurants/controller/restaurant_controller.dart)
- [cart_controller.dart](lib/features/cart/controller/cart_controller.dart)
- [checkout_controller.dart](lib/features/checkout/controller/checkout_controller.dart)
- [orders_controller.dart](lib/features/orders/controller/orders_controller.dart)

## Branch-Based Restaurant Model

The app is built around restaurant branches.

In [lib/core/models/restaurant.dart](lib/core/models/restaurant.dart):

- `Restaurant` stores brand-level data
- `RestaurantBranch` stores branch-level data

Each branch contains:

- `id`
- `name`
- `area`
- `address`
- `openHours`
- `phone`
- `distanceKm`
- `queueMinutes`
- `latitude`
- `longitude`
- `mapX`
- `mapY`
- `features`
- `isFlagship`
- `isOpen`

`Restaurant` also exposes helper values such as:

- `branchCount`
- `nearestBranch`

These are used heavily by cards, filters, and detail screens.

## Main User Flow

### 1. Authentication

Authentication screens live under `lib/features/auth/screen`.

Included screens:

- splash
- onboarding
- login
- signup
- forgot password
- OTP verification

Current auth behavior is mock/demo style and mainly drives app navigation.

### 2. Main Navigation

[lib/features/main_nav/screen/main_nav_screen.dart](lib/features/main_nav/screen/main_nav_screen.dart) is the shell after login/onboarding.

Bottom navigation tabs:

- Home
- Cart
- Orders
- Favorites
- Profile

The nav UI is custom and animated instead of the default plain Material bar.

### 3. Home Screen

The main home experience lives in:

- [home_controller.dart](lib/features/home/controller/home_controller.dart)
- [home_screen.dart](lib/features/home/screen/home_screen.dart)

Home screen behavior:

- Top brand/location header
- Notification shortcut
- Auto-rotating 3-slide promo carousel
- Search field shown directly on home
- Search suggestions from recent/trending terms
- Search results shown inline on home instead of forcing route navigation
- Food category chips that actually filter popular food
- Popular food section
- Branded branch listing section using `OptiZenqor_restaurant - BranchName`

The home search currently filters:

- foods by name/category
- restaurants by brand name or branch area/name

### 4. Restaurant Listing

Restaurant list feature files:

- [restaurant_controller.dart](lib/features/restaurants/controller/restaurant_controller.dart)
- [restaurant_filter.dart](lib/features/restaurants/model/restaurant_filter.dart)
- [restaurant_list_screen.dart](lib/features/restaurants/screen/restaurant_list_screen.dart)

Supported behavior:

- branch-aware filtering
- cuisine filtering
- rating filtering
- price range filtering
- nearest branch distance filtering
- sorting by recommended, rating, or nearest branch

### 5. Restaurant Detail

Restaurant detail lives in [restaurant_detail_screen.dart](lib/features/restaurants/screen/restaurant_detail_screen.dart).

Capabilities:

- branded hero header
- restaurant stats
- branch map section
- branch selection
- branch information card
- mock map button
- branch selection action
- category tab filtering for menu
- food listing
- add-on/customization sheet
- reviews section
- similar food section

The branch map UI itself is implemented in [branch_map_card.dart](lib/core/widgets/branch_map_card.dart).

## Search

Dedicated search route:

- [search_controller.dart](lib/features/search/controller/search_controller.dart)
- [search_screen.dart](lib/features/search/screen/search_screen.dart)

Capabilities:

- recent searches
- trending searches
- type-to-search
- search restaurants
- search dishes
- empty state

Home search and dedicated search both rely on shared search concepts, but the latest UX emphasizes inline home search results.

## Cart

Files:

- [cart_controller.dart](lib/features/cart/controller/cart_controller.dart)
- [cart_screen.dart](lib/features/cart/screen/cart_screen.dart)
- [cart_item_model.dart](lib/features/cart/model/cart_item_model.dart)

Capabilities:

- add items
- increment/decrement quantity
- remove items automatically when quantity reaches zero
- special instructions
- add-ons
- coupon code handling
- subtotal
- delivery charge
- tax
- discount
- total

Coupon support is mock-based and currently recognizes `SAVE10`.

## Checkout

Files:

- [checkout_controller.dart](lib/features/checkout/controller/checkout_controller.dart)
- [checkout_screen.dart](lib/features/checkout/screen/checkout_screen.dart)
- [order_success_screen.dart](lib/features/checkout/screen/order_success_screen.dart)

Capabilities:

- choose saved address
- choose payment method
- add delivery note
- review totals
- place order
- clear cart after placing order
- move to success screen

Mock helper actions also exist:

- add sample address
- add sample payment method

## Orders

Files:

- [orders_controller.dart](lib/features/orders/controller/orders_controller.dart)
- [my_orders_screen.dart](lib/features/orders/screen/my_orders_screen.dart)
- [order_tracking_screen.dart](lib/features/orders/screen/order_tracking_screen.dart)
- [order_detail_screen.dart](lib/features/orders/screen/order_detail_screen.dart)
- [review_screen.dart](lib/features/orders/screen/review_screen.dart)

Order tabs:

- Active
- Past
- Cancelled

Order capabilities:

- track active orders
- see order timeline
- review past orders
- reorder from past orders
- open order details
- submit a review
- trigger mock contact actions

## Notifications

Files:

- [notifications_controller.dart](lib/features/notifications/controller/notifications_controller.dart)
- [notifications_screen.dart](lib/features/notifications/screen/notifications_screen.dart)

Capabilities:

- list notifications
- swipe left to delete using `Dismissible`
- show empty state when no notifications remain

## Favorites

Files:

- [favorites_controller.dart](lib/features/favorites/controller/favorites_controller.dart)
- [favorites_screen.dart](lib/features/favorites/screen/favorites_screen.dart)

Used to favorite/unfavorite restaurants and reflect that state across the app.

## Profile and Account

Files:

- [profile_controller.dart](lib/features/profile/controller/profile_controller.dart)
- [profile_screen.dart](lib/features/profile/screen/profile_screen.dart)
- [edit_profile_screen.dart](lib/features/profile/screen/edit_profile_screen.dart)
- [saved_addresses_screen.dart](lib/features/profile/screen/saved_addresses_screen.dart)
- [payment_methods_screen.dart](lib/features/profile/screen/payment_methods_screen.dart)
- [help_support_screen.dart](lib/features/profile/screen/help_support_screen.dart)
- [legal_screen.dart](lib/features/profile/screen/legal_screen.dart)

Capabilities:

- view profile info
- edit profile
- manage saved addresses
- manage payment methods
- support/help pages
- legal pages

Saved addresses screen includes a styled location map section above the address list.

## Settings

Files:

- [settings_controller.dart](lib/features/settings/controller/settings_controller.dart)
- [settings_screen.dart](lib/features/settings/screen/settings_screen.dart)

This area holds user preferences and general app-level settings behavior.

## Reusable UI Components

Some important shared widgets:

- [app_shell.dart](lib/core/widgets/app_shell.dart)
- [app_search_field.dart](lib/core/widgets/app_search_field.dart)
- [primary_button.dart](lib/core/widgets/primary_button.dart)
- [restaurant_card.dart](lib/core/widgets/restaurant_card.dart)
- [food_item_card.dart](lib/core/widgets/food_item_card.dart)
- [section_header.dart](lib/core/widgets/section_header.dart)
- [loading_skeleton.dart](lib/core/widgets/loading_skeleton.dart)
- [empty_state.dart](lib/core/widgets/empty_state.dart)
- [branch_map_card.dart](lib/core/widgets/branch_map_card.dart)

## Theming

App theme is defined in [lib/app/theme/app_theme.dart](lib/app/theme/app_theme.dart).

Current theming setup includes:

- light theme
- dark theme
- DM Sans typography
- Material 3
- custom app background colors
- custom card and input styling

Shared colors are defined in [lib/core/constants/app_colors.dart](lib/core/constants/app_colors.dart).

## Utility Layer

[lib/core/utils/app_formatters.dart](lib/core/utils/app_formatters.dart) contains reusable formatting helpers such as:

- currency formatting
- time range formatting
- distance formatting

## Current Limitations

This app is not yet connected to a real backend or map SDK.

Current limitations:

- no real authentication backend
- no persistent local storage
- no live payments
- no real image assets for food/branches
- no live branch geolocation
- no Google Maps/TomTom integration yet
- no push notification backend
- no database/API sync

## How To Run

1. Install Flutter stable.
2. Run:

```bash
flutter pub get
```

3. Start the app:

```bash
flutter run
```

4. Optional quality check:

```bash
flutter analyze
```

## Recommended Next Steps

### Product

- replace placeholder branch maps with a real map SDK
- add real food and branch images
- unify brand naming everywhere to the final business format you want
- add reservation flow if the app is dine-in heavy

### Backend

- replace `MockApiService` with repository + API integration
- persist cart, auth, addresses, and favorites
- add real user profiles and order history from backend
- connect notifications to a real event source

### Engineering

- add widget tests for home, orders, cart, and notifications
- add controller tests for filtering and cart math
- split large UI screens into smaller widgets where helpful
- add environment configuration for staging/production APIs

## Documentation Intent

This README documents the app as it exists right now in the repository, not just the original starter structure. If major flows change later, this file should be updated alongside the code.
