# Screen Navigation Mapping

This document lists all the screens created and how they are mapped from the home screen options.

## New Screens Created

### 1. **Bills & Recharge Screen** (`bills_recharge_screen.dart`)
   - Handles all recharge and bill payment services
   - **Mapped from:**
     - Mobile Recharge
     - DTH Recharge
     - Electricity Bill
     - Water Bill
     - Gas Bill
   - **Features:**
     - Service type selector
     - Payment form with validation
     - Quick amount buttons
     - Recent transactions list

### 2. **Credit Card Screen** (`credit_card_screen.dart`)
   - Displays credit card details and management
   - **Mapped from:**
     - Credit Card (Quick Actions)
     - EMI Card icon (Top bar)
   - **Features:**
     - Virtual credit card display
     - Credit limit tracker
     - Quick actions (Pay Bill, Transactions, Rewards, Block Card)
     - Recent transactions
     - Apply for new card option

### 3. **Offers Screen** (`offers_screen.dart`)
   - Shows all available offers and deals
   - **Mapped from:**
     - Offer (Quick Actions)
     - Some loan offer cards
   - **Features:**
     - Featured banner
     - Category-wise offers
     - Top offers from MockDataService
     - Additional offer categories (Electronics, Travel, Wedding, Medical, Education)

### 4. **Finance Manager Screen** (`finance_manager_screen.dart`)
   - Personal finance tracking and management
   - **Mapped from:**
     - Finance Manager (Quick Actions)
   - **Features:**
     - Total balance overview
     - Income vs Expenses tracking
     - Investments and Savings summary
     - Monthly budget tracker
     - Recent transactions
     - Financial goals tracker
     - Add transaction functionality

### 5. **Investment/Stock Market Screen** (`investment_screen.dart`)
   - Stock market and investment management
   - **Mapped from:**
     - Stock Market (Quick Actions)
   - **Features:**
     - Portfolio value summary
     - Buy/Sell/SIP quick actions
     - Market indices (NIFTY, SENSEX, NIFTY BANK)
     - Holdings with real-time data
     - Investment options (Mutual Funds, FD, Gold, Insurance)
     - Market news and updates

### 6. **Product EMI Screen** (`product_emi_screen.dart`)
   - EMI options for electronic products
   - **Mapped from:**
     - All electronics items (Smartphones, Laptops, TVs, AC, Refrigerator)
     - EMI types (AC EMI, Mobile EMI)
     - Grocery (Quick Actions)
   - **Features:**
     - Category selector
     - 0% Interest EMI banner
     - Featured products with pricing
     - EMI calculator
     - Product cards with buy option

### 7. **Notifications Screen** (`notifications_screen.dart`)
   - All app notifications and alerts
   - **Mapped from:**
     - Notification icon (Top bar)
   - **Features:**
     - Grouped by time (Today, Yesterday, This Week, Older)
     - Different notification types (EMI Due, Offers, Payments, KYC, Rewards)
     - Mark all as read functionality
     - Unread indicator

### 8. **Cart Screen** (`cart_screen.dart`)
   - Shopping cart for product purchases
   - **Mapped from:**
     - Cart icon (Top bar)
   - **Features:**
     - Product list with images
     - Quantity management
     - Remove item option
     - Price breakdown
     - EMI calculation
     - Checkout functionality
     - Empty cart state

## Existing Screens (Already Created)

### 9. **Loans Screen** (`loans_screen.dart`)
   - **Mapped from:**
     - Loans (Quick Actions)
     - Personal Loan (EMI Types)
     - Home Loan (EMI Types)
     - Loan offer cards (Personal Loan, Home Loan, Gold Loan)
     - Promo banner "Apply" button

### 10. **EMI Card Screen** (`emi_card_screen.dart`)
   - **Mapped from:**
     - EMI Card icon (Top bar)
     - "Explore EMI Options" button (Big EMI Card)

### 11. **Profile Screen** (`profile_screen.dart`)
   - **Mapped from:**
     - Profile icon (Bottom Navigation)

### 12. **Scan QR Screen** (`scan_qr_screen.dart`)
   - **Mapped from:**
     - Scan QR icon (Bottom Navigation)

### 13. **Pay EMI Screen** (`pay_emi_screen.dart`)
   - **Mapped from:**
     - Pay EMI icon (Bottom Navigation)

### 14. **Menu Screen** (`menu_screen.dart`)
   - **Mapped from:**
     - Menu icon (Bottom Navigation)

### 15. **Chat Screen** (`chat_screen.dart`)
   - **Mapped from:**
     - Chat icon (Bottom Navigation)

## Home Screen Elements and Navigation

### Top Bar
- **App Logo**: Static (no navigation)
- **Cart Icon** → `CartScreen`
- **EMI Card Icon** → `EmiCardScreen`
- **Prime Badge**: Static (no navigation)
- **Notification Icon** → `NotificationsScreen`
- **Search Bar**: No navigation yet (can be enhanced)

### Promo Banner
- **Apply Button** → `LoansScreen`

### Quick Actions Grid (6 items)
1. **Offer** → `OffersScreen`
2. **Loans** → `LoansScreen`
3. **Credit Card** → `CreditCardScreen`
4. **Grocery** → `ProductEmiScreen`
5. **Finance Manager** → `FinanceManagerScreen`
6. **Stock Market** → `InvestmentScreen`

### EMI Types Row (6 items)
1. **Gold Loan** → `LoansScreen`
2. **AC EMI** → `ProductEmiScreen`
3. **Personal Loan** → `LoansScreen`
4. **Two Wheeler** → `LoansScreen`
5. **Mobile EMI** → `ProductEmiScreen`
6. **Home Loan** → `LoansScreen`

### Big EMI Card
- **Explore EMI Options Button** → `EmiCardScreen`

### Bills & Recharge Row (5 items)
1. **Mobile Recharge** → `BillsRechargeScreen(serviceType: 'mobile')`
2. **DTH Recharge** → `BillsRechargeScreen(serviceType: 'dth')`
3. **Electricity Bill** → `BillsRechargeScreen(serviceType: 'electricity')`
4. **Water Bill** → `BillsRechargeScreen(serviceType: 'water')`
5. **Gas Bill** → `BillsRechargeScreen(serviceType: 'gas')`

### Electronics Row (5 items)
1. **Smartphones** → `ProductEmiScreen(productType: 'smartphones')`
2. **Laptops** → `ProductEmiScreen(productType: 'laptops')`
3. **TVs** → `ProductEmiScreen(productType: 'tvs')`
4. **AC** → `ProductEmiScreen(productType: 'ac')`
5. **Refrigerator** → `ProductEmiScreen(productType: 'refrigerator')`

### Loan Offers Row (3+ items)
1. **Personal Loan** → `LoansScreen`
2. **Home Loan** → `LoansScreen`
3. **Gold Loan** → `LoansScreen`
- Other offers navigate based on title - defaults to `OffersScreen`

## Summary

✅ **Total Screens**: 15
✅ **New Screens Created**: 8
✅ **Existing Screens**: 7
✅ **All Home Screen Options**: Fully mapped and functional
✅ **Navigation**: Implemented using MaterialPageRoute
✅ **No Errors**: All screens compile successfully

## Next Steps (Optional Enhancements)

1. Add search functionality to the search bar
2. Implement actual payment gateway integration
3. Add more product categories and real product data
4. Implement state management (Provider/Riverpod/Bloc)
5. Add authentication and user session management
6. Connect to backend APIs for real-time data
7. Add animations and transitions
8. Implement deep linking
9. Add biometric authentication
10. Integrate push notifications
