# OptiZenqor Restaurant

Production-ready Flutter frontend for a restaurant food ordering app focused only on the user/customer side.

## Highlights

- GetX state management and navigation
- Clean feature-first folder structure
- Mock-data-first and API-ready service layer
- Full user journey: auth, discovery, restaurant browsing, cart, checkout, tracking, favorites, notifications, profile, and settings
- Reusable widgets and premium mobile-first UI

## Folder Structure

```text
lib/
├── app/
│   ├── app.dart
│   ├── bindings/
│   ├── routes/
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
│   │   ├── controller/
│   │   ├── model/
│   │   └── screen/
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
└── main.dart
```

## Main User Modules

- Authentication: splash, onboarding, login, signup, forgot password, OTP, social login placeholders
- Home: location, search, categories, banners, popular restaurants, nearby and top picks
- Restaurants: listing, sorting, filtering, detail page, dynamic menu tabs, add-ons, reviews, add to cart
- Search: recent, trending, suggestions, restaurant and dish search, empty state
- Cart and checkout: quantity control, notes, coupon UI, address selection, payment selection, success flow
- Orders: active orders, past orders, order detail, timeline tracking, reorder, ratings
- Account: notifications, favorites, profile, addresses, payment methods, legal, support, settings

## Architecture Notes

- Shared domain models live in `core/models`
- Mock backend entry points live in `core/services/mock_api_service.dart`
- Screens/controllers/models stay inside each feature folder
- `app/routes` owns named navigation and `app/bindings` wires the global controllers
- The app is ready to swap mock service methods with real repository or API calls later

## Setup

1. Install Flutter 3.24+ or a compatible stable version.
2. Run `flutter pub get`
3. Run `flutter run`

## Suggested Next Backend Integration Steps

1. Replace `MockApiService` methods with repository interfaces and remote data sources.
2. Persist auth, cart, favorites, addresses, and settings with API plus local cache.
3. Add real images, payment SDK integration, localization files, and push notifications.
4. Expand test coverage for controllers, routes, and widget flows.
