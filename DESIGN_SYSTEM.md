# HoodJunction Design System

## 🎨 Overview

The HoodJunction Design System provides a comprehensive set of design tokens, components, and guidelines to ensure consistency across the entire application. It's built with Flutter's Material Design 3 principles and includes custom tokens for society management use cases.

## 🏗️ Architecture

### Core Theme Structure
```
lib/core/theme/
├── app_theme.dart          # Main theme configuration
├── app_colors.dart         # Color palette and schemes
├── app_typography.dart     # Typography system
├── app_dimensions.dart     # Spacing, sizing, and layout
├── design_system.dart      # Context extensions and utilities
└── design_system_exports.dart # Single import point
```

### Design System Widgets
```
lib/widgets/design_system/
├── ds_button.dart          # Button variants
├── ds_text_field.dart      # Input field variants
├── ds_card.dart           # Card variants
├── ds_avatar.dart         # Avatar components
├── ds_badge.dart          # Badge and status indicators
└── ds_spacing.dart        # Layout and spacing widgets
```

## 🎯 Design Tokens

### Colors

#### Primary Palette
- **Primary Green**: `#2E7D32` - Main brand color
- **Primary Green Light**: `#60AD5E` - Lighter variant
- **Primary Green Dark**: `#005005` - Darker variant

#### Secondary Palette
- **Secondary Blue**: `#1976D2` - Secondary actions
- **Accent Orange**: `#FF9800` - Warnings and highlights

#### Semantic Colors
- **Success**: `#4CAF50` - Success states
- **Warning**: `#FF9800` - Warning states
- **Error**: `#E53935` - Error states
- **Info**: `#2196F3` - Information states

#### Neutral Palette
- **Neutral 50-900**: Complete grayscale palette
- **Surface Colors**: Light and dark surface variants
- **Background Colors**: Application backgrounds

#### Usage Examples
```dart
// Using colors in widgets
Container(
  color: context.colorScheme.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: context.colorScheme.onPrimary),
  ),
)

// Using semantic colors
Container(
  color: AppColors.success,
  child: Text('Success message'),
)

// Using status colors
Container(
  color: context.statusColor('approved'),
  child: Text('Approved'),
)
```

### Typography

#### Font Families
- **Primary**: Inter - Clean, readable sans-serif
- **Display**: Poppins - Bold headings and titles
- **Secondary**: Roboto - System fallback

#### Type Scale
- **Display Large**: 40px, Bold - Hero titles
- **Display Medium**: 32px, Bold - Page titles
- **Display Small**: 24px, SemiBold - Section titles
- **Headline Large**: 20px, SemiBold - Card titles
- **Headline Medium**: 18px, SemiBold - Subsection titles
- **Headline Small**: 16px, Medium - List titles
- **Title Large**: 16px, SemiBold - Button text
- **Title Medium**: 14px, Medium - Form labels
- **Title Small**: 12px, Medium - Captions
- **Body Large**: 16px, Regular - Primary body text
- **Body Medium**: 14px, Regular - Secondary body text
- **Body Small**: 12px, Regular - Helper text
- **Label Large**: 14px, Medium - Button labels
- **Label Medium**: 12px, Medium - Chip labels
- **Label Small**: 10px, Medium - Badge labels

#### Usage Examples
```dart
// Using text styles
Text(
  'Hero Title',
  style: context.heroTitle,
)

Text(
  'Section Title',
  style: context.sectionTitle,
)

Text(
  'Body text',
  style: context.textTheme.bodyMedium,
)

// Responsive typography
Text(
  'Responsive Title',
  style: context.responsiveTitle,
)
```

### Dimensions

#### Spacing Scale
- **XSmall**: 4px - Tight spacing
- **Small**: 8px - Close elements
- **Medium**: 16px - Standard spacing
- **Large**: 24px - Section spacing
- **XLarge**: 32px - Page spacing
- **XXLarge**: 48px - Major sections

#### Border Radius
- **XSmall**: 4px - Small elements
- **Small**: 8px - Buttons, chips
- **Medium**: 12px - Cards, inputs
- **Large**: 16px - Containers
- **XLarge**: 20px - Modals
- **XXLarge**: 24px - Large containers
- **Circular**: 50px - Circular elements

#### Component Sizes
- **Button Height**: 48px (36px small, 56px large)
- **Input Height**: 48px (36px small, 56px large)
- **Card Elevation**: 2dp (4dp hover, 1dp pressed)
- **Icon Sizes**: 12px, 16px, 20px, 24px, 32px, 48px, 64px
- **Avatar Sizes**: 24px, 32px, 48px, 64px, 96px

#### Usage Examples
```dart
// Using spacing
Padding(
  padding: EdgeInsets.all(AppDimensions.paddingMedium),
  child: child,
)

// Using responsive spacing
DSSpacing.medium(), // Vertical spacing
DSSpacing.horizontal(SpacingSize.large), // Horizontal spacing

// Using responsive dimensions
Container(
  padding: EdgeInsets.all(context.responsivePadding),
  child: child,
)
```

## 🧩 Components

### Buttons

#### Variants
- **Primary**: Filled button for primary actions
- **Secondary**: Outlined button for secondary actions
- **Tertiary**: Filled tonal button for tertiary actions
- **Ghost**: Text button for subtle actions
- **Danger**: Error-colored button for destructive actions

#### Sizes
- **Small**: 36px height - Compact spaces
- **Medium**: 48px height - Standard size
- **Large**: 56px height - Prominent actions

#### Usage Examples
```dart
// Primary button
DSButton.primary(
  text: 'Save',
  onPressed: () {},
  icon: Icons.save,
)

// Secondary button
DSButton.secondary(
  text: 'Cancel',
  onPressed: () {},
  size: ButtonSize.small,
)

// Loading state
DSButton(
  text: 'Submit',
  onPressed: () {},
  isLoading: true,
)

// Full width
DSButton(
  text: 'Continue',
  onPressed: () {},
  isFullWidth: true,
)
```

### Text Fields

#### Variants
- **Outlined**: Default outlined input
- **Filled**: Filled background input
- **Underlined**: Underlined input

#### Features
- Label and hint text support
- Prefix and suffix icons
- Validation and error states
- Password visibility toggle
- Character counting
- Multi-line support

#### Usage Examples
```dart
// Basic text field
DSTextField.outlined(
  controller: controller,
  label: 'Email',
  prefixIcon: Icons.email,
  validator: (value) => value?.isEmpty == true ? 'Required' : null,
)

// Password field
DSTextField(
  controller: passwordController,
  label: 'Password',
  obscureText: true,
  prefixIcon: Icons.lock,
)

// Multi-line field
DSTextField.filled(
  controller: messageController,
  label: 'Message',
  maxLines: 4,
  hintText: 'Enter your message...',
)
```

### Cards

#### Variants
- **Elevated**: Standard elevated card
- **Outlined**: Outlined card with border
- **Filled**: Filled background card

#### Specialized Cards
- **Info Card**: Icon, title, and subtitle
- **Stat Card**: Statistics display with trend
- **Action Card**: Clickable action with icon

#### Usage Examples
```dart
// Basic card
DSCard.elevated(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Card content'),
  ),
  onTap: () {},
)

// Info card
DSInfoCard(
  title: 'Total Units',
  subtitle: '120 units available',
  icon: Icons.home,
  iconColor: Colors.blue,
  onTap: () {},
)

// Stat card
DSStatCard(
  title: 'Pending Bills',
  value: '₹25,000',
  subtitle: '12 bills',
  icon: Icons.pending_actions,
  color: Colors.orange,
)
```

### Avatars

#### Sizes
- **Small**: 24px - List items
- **Medium**: 32px - Standard size
- **Large**: 48px - Profile headers
- **Extra Large**: 64px - Profile pages

#### Features
- Image loading with fallback
- Initial letters generation
- Custom placeholder icons
- Border support
- Badge overlay support
- Avatar groups with overflow

#### Usage Examples
```dart
// Basic avatar
DSAvatar.medium(
  imageUrl: user.profilePicture,
  name: user.displayName,
)

// Avatar with badge
DSAvatar.large(
  imageUrl: user.profilePicture,
  name: user.displayName,
  badge: DSAvatarBadge.online(),
)

// Avatar group
DSAvatarGroup(
  imageUrls: userImages,
  names: userNames,
  maxVisible: 3,
  onMoreTap: () {},
)
```

### Badges

#### Variants
- **Primary**: Primary color badge
- **Secondary**: Outlined badge
- **Success**: Success state badge
- **Warning**: Warning state badge
- **Error**: Error state badge
- **Info**: Information badge

#### Specialized Badges
- **Status Badge**: Automatic status styling
- **Role Badge**: User role indicators
- **Count Badge**: Notification counters
- **Dot Badge**: Simple dot indicators

#### Usage Examples
```dart
// Basic badge
DSBadge.primary(
  text: 'New',
  icon: Icons.star,
)

// Status badge
DSStatusBadge(
  status: 'approved',
  isSmall: true,
)

// Count badge
DSCountBadge(
  count: 5,
  maxCount: 99,
)
```

## 📱 Responsive Design

### Breakpoints
- **Mobile**: < 600px
- **Tablet**: 600px - 1024px
- **Desktop**: > 1024px

### Responsive Utilities
```dart
// Device detection
if (context.isMobile) {
  // Mobile layout
} else if (context.isTablet) {
  // Tablet layout
} else {
  // Desktop layout
}

// Responsive values
final padding = context.responsivePadding;
final iconSize = context.responsiveIconSize;
final buttonHeight = context.responsiveButtonHeight;

// Responsive typography
Text(
  'Title',
  style: context.responsiveTitle,
)
```

### Grid System
```dart
// Responsive grid columns
final columns = AppDimensions.getGridColumnCount(
  context,
  itemWidth: 200.0,
);

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
    crossAxisSpacing: AppDimensions.gridSpacing,
    mainAxisSpacing: AppDimensions.gridSpacing,
  ),
  itemBuilder: (context, index) => GridItem(),
)
```

## 🎭 Theme Modes

### Light Theme
- Clean, bright interface
- High contrast for readability
- Green primary color scheme

### Dark Theme
- Dark surfaces with light text
- Reduced eye strain
- Consistent color relationships

### System Theme
- Automatically follows system preference
- Smooth transitions between modes

## 🔧 Customization

### Custom Colors
```dart
// Add custom colors to AppColors
static const Color customPurple = Color(0xFF6A1B9A);

// Use in components
DSButton(
  text: 'Custom',
  customColor: AppColors.customPurple,
  onPressed: () {},
)
```

### Custom Typography
```dart
// Extend typography
static TextStyle get customStyle => GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);

// Use in widgets
Text(
  'Custom Text',
  style: AppTypography.customStyle,
)
```

### Theme Overrides
```dart
// Override theme properties
ThemeData customTheme = AppTheme.lightTheme.copyWith(
  primaryColor: Colors.purple,
  // Other overrides
);
```

## 📋 Usage Guidelines

### Do's
✅ Use design system components consistently
✅ Follow spacing and sizing guidelines
✅ Use semantic colors for status indicators
✅ Implement responsive layouts
✅ Test in both light and dark modes
✅ Use proper contrast ratios
✅ Follow accessibility guidelines

### Don'ts
❌ Create custom components without design system tokens
❌ Use hardcoded colors or dimensions
❌ Ignore responsive design principles
❌ Mix different design patterns
❌ Use colors without semantic meaning
❌ Create inconsistent spacing

## 🧪 Testing

### Visual Testing
- Test all components in light and dark modes
- Verify responsive behavior across devices
- Check accessibility compliance
- Validate color contrast ratios

### Component Testing
```dart
testWidgets('DSButton renders correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.lightTheme,
      home: DSButton.primary(
        text: 'Test',
        onPressed: () {},
      ),
    ),
  );
  
  expect(find.text('Test'), findsOneWidget);
  expect(find.byType(ElevatedButton), findsOneWidget);
});
```

## 📚 Resources

### Design Tokens
- [Material Design 3](https://m3.material.io/)
- [Color System](https://m3.material.io/styles/color/system)
- [Typography](https://m3.material.io/styles/typography)

### Accessibility
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Flutter Accessibility](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)

### Implementation
- [Flutter Theming](https://docs.flutter.dev/cookbook/design/themes)
- [Google Fonts](https://pub.dev/packages/google_fonts)

---

**Built with ❤️ for consistent, accessible, and beautiful user interfaces**