import 'package:flutter/material.dart';
import '../core/theme/design_system_exports.dart';

class ThemeShowcaseScreen extends StatefulWidget {
  const ThemeShowcaseScreen({super.key});

  @override
  State<ThemeShowcaseScreen> createState() => _ThemeShowcaseScreenState();
}

class _ThemeShowcaseScreenState extends State<ThemeShowcaseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _switchValue = false;
  bool _checkboxValue = false;
  int _radioValue = 1;
  double _sliderValue = 0.5;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Showcase'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Buttons'),
            Tab(text: 'Inputs'),
            Tab(text: 'Cards'),
            Tab(text: 'Navigation'),
            Tab(text: 'Controls'),
            Tab(text: 'Feedback'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildButtonsTab(),
          _buildInputsTab(),
          _buildCardsTab(),
          _buildNavigationTab(),
          _buildControlsTab(),
          _buildFeedbackTab(),
        ],
      ),
    );
  }

  Widget _buildButtonsTab() {
    return DSResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Buttons', style: context.sectionTitle),
          DSSpacing.medium(),
          
          // Primary Buttons
          Text('Primary Buttons', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          Row(
            children: [
              Expanded(
                child: DSButton.primary(
                  text: 'Primary',
                  onPressed: () {},
                ),
              ),
              DSSpacing.horizontal(SpacingSize.small),
              Expanded(
                child: DSButton.primary(
                  text: 'With Icon',
                  icon: Icons.star,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          DSSpacing.small(),
          DSButton.primary(
            text: 'Loading',
            isLoading: true,
            onPressed: () {},
          ),
          
          DSSpacing.medium(),
          
          // Secondary Buttons
          Text('Secondary Buttons', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          Row(
            children: [
              Expanded(
                child: DSButton.secondary(
                  text: 'Secondary',
                  onPressed: () {},
                ),
              ),
              DSSpacing.horizontal(SpacingSize.small),
              Expanded(
                child: DSButton.tertiary(
                  text: 'Tertiary',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          
          DSSpacing.medium(),
          
          // Other Buttons
          Text('Other Variants', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          Row(
            children: [
              Expanded(
                child: DSButton.ghost(
                  text: 'Ghost',
                  onPressed: () {},
                ),
              ),
              DSSpacing.horizontal(SpacingSize.small),
              Expanded(
                child: DSButton.danger(
                  text: 'Danger',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          
          DSSpacing.medium(),
          
          // Button Sizes
          Text('Button Sizes', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          DSButton(
            text: 'Small Button',
            size: ButtonSize.small,
            onPressed: () {},
          ),
          DSSpacing.small(),
          DSButton(
            text: 'Medium Button',
            size: ButtonSize.medium,
            onPressed: () {},
          ),
          DSSpacing.small(),
          DSButton(
            text: 'Large Button',
            size: ButtonSize.large,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildInputsTab() {
    return DSResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Text Fields', style: context.sectionTitle),
          DSSpacing.medium(),
          
          DSTextField.outlined(
            label: 'Outlined Field',
            hintText: 'Enter text here...',
            prefixIcon: Icons.person,
          ),
          DSSpacing.medium(),
          
          DSTextField.filled(
            label: 'Filled Field',
            hintText: 'Enter text here...',
            prefixIcon: Icons.email,
          ),
          DSSpacing.medium(),
          
          DSTextField.underlined(
            label: 'Underlined Field',
            hintText: 'Enter text here...',
            prefixIcon: Icons.phone,
          ),
          DSSpacing.medium(),
          
          DSTextField(
            label: 'Password Field',
            hintText: 'Enter password...',
            obscureText: true,
            prefixIcon: Icons.lock,
          ),
          DSSpacing.medium(),
          
          DSTextField(
            label: 'Multi-line Field',
            hintText: 'Enter your message...',
            maxLines: 4,
            prefixIcon: Icons.message,
          ),
          DSSpacing.medium(),
          
          DSTextField(
            label: 'Required Field',
            hintText: 'This field is required',
            isRequired: true,
            prefixIcon: Icons.star,
            validator: (value) => value?.isEmpty == true ? 'This field is required' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCardsTab() {
    return DSResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cards', style: context.sectionTitle),
          DSSpacing.medium(),
          
          // Basic Cards
          Text('Basic Cards', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          DSCard.elevated(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.paddingMedium),
              child: Text('Elevated Card'),
            ),
          ),
          
          DSCard.outlined(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.paddingMedium),
              child: Text('Outlined Card'),
            ),
          ),
          
          DSCard.filled(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.paddingMedium),
              child: Text('Filled Card'),
            ),
          ),
          
          DSSpacing.medium(),
          
          // Specialized Cards
          Text('Specialized Cards', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          DSInfoCard(
            title: 'Info Card',
            subtitle: 'This is an info card with icon',
            icon: Icons.info,
            iconColor: Colors.blue,
            onTap: () {},
          ),
          
          DSStatCard(
            title: 'Total Users',
            value: '1,234',
            subtitle: '12% increase',
            icon: Icons.people,
            color: Colors.green,
            onTap: () {},
          ),
          
          DSActionCard(
            title: 'Quick Action',
            description: 'Tap to perform action',
            icon: Icons.flash_on,
            color: Colors.orange,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTab() {
    return DSResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Navigation', style: context.sectionTitle),
          DSSpacing.medium(),
          
          // Tabs
          Text('Tabs', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          Container(
            height: 200,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Tab 1'),
                      Tab(text: 'Tab 2'),
                      Tab(text: 'Tab 3'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(child: Text('Tab 1 Content')),
                        Center(child: Text('Tab 2 Content')),
                        Center(child: Text('Tab 3 Content')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          DSSpacing.medium(),
          
          // List Tiles
          Text('List Tiles', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            subtitle: Text('Navigate to home'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            subtitle: Text('App settings'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          
          DSSpacing.medium(),
          
          // Avatars
          Text('Avatars', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          Row(
            children: [
              DSAvatar.small(name: 'John Doe'),
              DSSpacing.horizontal(SpacingSize.small),
              DSAvatar.medium(name: 'Jane Smith'),
              DSSpacing.horizontal(SpacingSize.small),
              DSAvatar.large(name: 'Bob Johnson'),
              DSSpacing.horizontal(SpacingSize.small),
              DSAvatar.extraLarge(name: 'Alice Brown'),
            ],
          ),
          
          DSSpacing.medium(),
          
          DSAvatarGroup(
            names: ['John', 'Jane', 'Bob', 'Alice', 'Charlie'],
            maxVisible: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildControlsTab() {
    return DSResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Form Controls', style: context.sectionTitle),
          DSSpacing.medium(),
          
          // Switch
          SwitchListTile(
            title: Text('Enable Notifications'),
            subtitle: Text('Receive push notifications'),
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
          
          // Checkbox
          CheckboxListTile(
            title: Text('Accept Terms'),
            subtitle: Text('I agree to the terms and conditions'),
            value: _checkboxValue,
            onChanged: (value) {
              setState(() {
                _checkboxValue = value ?? false;
              });
            },
          ),
          
          // Radio Buttons
          Text('Select Option', style: context.textTheme.titleMedium),
          RadioListTile<int>(
            title: Text('Option 1'),
            value: 1,
            groupValue: _radioValue,
            onChanged: (value) {
              setState(() {
                _radioValue = value ?? 1;
              });
            },
          ),
          RadioListTile<int>(
            title: Text('Option 2'),
            value: 2,
            groupValue: _radioValue,
            onChanged: (value) {
              setState(() {
                _radioValue = value ?? 1;
              });
            },
          ),
          
          DSSpacing.medium(),
          
          // Slider
          Text('Volume: ${(_sliderValue * 100).round()}%', style: context.textTheme.titleMedium),
          Slider(
            value: _sliderValue,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
          
          DSSpacing.medium(),
          
          // Progress Indicators
          Text('Progress Indicators', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          LinearProgressIndicator(value: 0.7),
          DSSpacing.small(),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildFeedbackTab() {
    return DSResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Feedback', style: context.sectionTitle),
          DSSpacing.medium(),
          
          // Badges
          Text('Badges', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              DSBadge.primary(text: 'Primary'),
              DSBadge.secondary(text: 'Secondary'),
              DSBadge.success(text: 'Success'),
              DSBadge.warning(text: 'Warning'),
              DSBadge.error(text: 'Error'),
              DSBadge.info(text: 'Info'),
            ],
          ),
          
          DSSpacing.medium(),
          
          // Status Badges
          Text('Status Badges', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              DSStatusBadge(status: 'pending'),
              DSStatusBadge(status: 'approved'),
              DSStatusBadge(status: 'rejected'),
              DSStatusBadge(status: 'active'),
              DSStatusBadge(status: 'inactive'),
            ],
          ),
          
          DSSpacing.medium(),
          
          // Count Badges
          Text('Count Badges', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          Row(
            children: [
              Stack(
                children: [
                  Icon(Icons.notifications, size: 32),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: DSCountBadge(count: 5),
                  ),
                ],
              ),
              DSSpacing.horizontal(SpacingSize.medium),
              Stack(
                children: [
                  Icon(Icons.message, size: 32),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: DSCountBadge(count: 99, maxCount: 99),
                  ),
                ],
              ),
              DSSpacing.horizontal(SpacingSize.medium),
              Stack(
                children: [
                  Icon(Icons.email, size: 32),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: DSDotBadge(),
                  ),
                ],
              ),
            ],
          ),
          
          DSSpacing.medium(),
          
          // Snackbar Demo
          Text('Snackbars', style: context.textTheme.titleMedium),
          DSSpacing.small(),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.showSnackbar('Success message!', type: SnackbarType.success);
                },
                child: Text('Success'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.showSnackbar('Error message!', type: SnackbarType.error);
                },
                child: Text('Error'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.showSnackbar('Warning message!', type: SnackbarType.warning);
                },
                child: Text('Warning'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.showSnackbar('Info message!', type: SnackbarType.info);
                },
                child: Text('Info'),
              ),
            ],
          ),
          
          DSSpacing.medium(),
          
          // Dialog Demo
          ElevatedButton(
            onPressed: () {
              context.showAppDialog(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Dialog Title', style: context.textTheme.headlineSmall),
                      DSSpacing.medium(),
                      Text('This is a sample dialog with design system styling.'),
                      DSSpacing.large(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          DSSpacing.horizontal(SpacingSize.small),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Text('Show Dialog'),
          ),
        ],
      ),
    );
  }
}