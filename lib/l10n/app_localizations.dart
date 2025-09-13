import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @choose_language.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get choose_language;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @full_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name_hint;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get email_hint;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @phone_number_hint.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number_hint;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @role_hint.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role_hint;

  /// No description provided for @organizer.
  ///
  /// In en, this message translates to:
  /// **'Organizer'**
  String get organizer;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @birth_date.
  ///
  /// In en, this message translates to:
  /// **'Birth of date'**
  String get birth_date;

  /// No description provided for @governorates.
  ///
  /// In en, this message translates to:
  /// **'Governorates'**
  String get governorates;

  /// No description provided for @districts.
  ///
  /// In en, this message translates to:
  /// **'Districts'**
  String get districts;

  /// No description provided for @association_name.
  ///
  /// In en, this message translates to:
  /// **'Association Name'**
  String get association_name;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @passwords_not_match.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match.'**
  String get passwords_not_match;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @onboard_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our app'**
  String get onboard_welcome_title;

  /// No description provided for @onboard_welcome_body.
  ///
  /// In en, this message translates to:
  /// **'A short explanation of the first feature and how it helps users.'**
  String get onboard_welcome_body;

  /// No description provided for @onboard_feature_title.
  ///
  /// In en, this message translates to:
  /// **'Awesome Feature'**
  String get onboard_feature_title;

  /// No description provided for @onboard_feature_body.
  ///
  /// In en, this message translates to:
  /// **'A simple explanation of the second feature with a small example or direct benefit.'**
  String get onboard_feature_body;

  /// No description provided for @onboard_get_started_title.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboard_get_started_title;

  /// No description provided for @onboard_get_started_body.
  ///
  /// In en, this message translates to:
  /// **'Done! Tap Get Started to start using the app.'**
  String get onboard_get_started_body;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @event_details.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get event_details;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @status_is.
  ///
  /// In en, this message translates to:
  /// **'Status is'**
  String get status_is;

  /// No description provided for @rejection_reason.
  ///
  /// In en, this message translates to:
  /// **'Rejection Reason:'**
  String get rejection_reason;

  /// No description provided for @complete_event.
  ///
  /// In en, this message translates to:
  /// **'Complete Event'**
  String get complete_event;

  /// No description provided for @generate_qr_checkout.
  ///
  /// In en, this message translates to:
  /// **'Generate Qr Check Out'**
  String get generate_qr_checkout;

  /// No description provided for @generate_qr_checkin.
  ///
  /// In en, this message translates to:
  /// **'Generate Qr CheckIn'**
  String get generate_qr_checkin;

  /// No description provided for @volunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get volunteer;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @total_volunteer.
  ///
  /// In en, this message translates to:
  /// **'Total Volunteer'**
  String get total_volunteer;

  /// No description provided for @search_result.
  ///
  /// In en, this message translates to:
  /// **'Search Result'**
  String get search_result;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @check_in.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get check_in;

  /// No description provided for @check_out.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get check_out;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @pledges.
  ///
  /// In en, this message translates to:
  /// **'Pledges'**
  String get pledges;

  /// No description provided for @item_amount.
  ///
  /// In en, this message translates to:
  /// **'Item/Amount'**
  String get item_amount;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @owner_name.
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get owner_name;

  /// No description provided for @owner_phone.
  ///
  /// In en, this message translates to:
  /// **'Owner Phone'**
  String get owner_phone;

  /// No description provided for @owner_email.
  ///
  /// In en, this message translates to:
  /// **'Owner Email'**
  String get owner_email;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @verified_volunteer.
  ///
  /// In en, this message translates to:
  /// **'Verified Volunteer'**
  String get verified_volunteer;

  /// No description provided for @worked_hours.
  ///
  /// In en, this message translates to:
  /// **'Worked Hours'**
  String get worked_hours;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @volunteer_no_show.
  ///
  /// In en, this message translates to:
  /// **'Volunteer NoShow'**
  String get volunteer_no_show;

  /// No description provided for @confirm_no_show.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to change your event volunteer status to no-show?'**
  String get confirm_no_show;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirm_complete_event.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to complete event?'**
  String get confirm_complete_event;

  /// No description provided for @update_status_pledge.
  ///
  /// In en, this message translates to:
  /// **'Update Status Pledge'**
  String get update_status_pledge;

  /// No description provided for @select_pledge_status.
  ///
  /// In en, this message translates to:
  /// **'Select pledge status'**
  String get select_pledge_status;

  /// No description provided for @report_user.
  ///
  /// In en, this message translates to:
  /// **'Report User'**
  String get report_user;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @my_event.
  ///
  /// In en, this message translates to:
  /// **'My Event'**
  String get my_event;

  /// No description provided for @no_data_available.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get no_data_available;

  /// No description provided for @registered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get registered;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @show_details.
  ///
  /// In en, this message translates to:
  /// **'Show Details'**
  String get show_details;

  /// No description provided for @add_new_event.
  ///
  /// In en, this message translates to:
  /// **'Add New Event'**
  String get add_new_event;

  /// No description provided for @update_event.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get update_event;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @start_event_date.
  ///
  /// In en, this message translates to:
  /// **'Start Event Date'**
  String get start_event_date;

  /// No description provided for @end_event_date.
  ///
  /// In en, this message translates to:
  /// **'End Event Date'**
  String get end_event_date;

  /// No description provided for @pick.
  ///
  /// In en, this message translates to:
  /// **'Pick'**
  String get pick;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @max_volunteers.
  ///
  /// In en, this message translates to:
  /// **'Max Volunteers'**
  String get max_volunteers;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @delete_event.
  ///
  /// In en, this message translates to:
  /// **'Delete Event'**
  String get delete_event;

  /// No description provided for @delete_event_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the Event and its associated data?'**
  String get delete_event_confirmation;

  /// No description provided for @pledge_event.
  ///
  /// In en, this message translates to:
  /// **'Pledge Event'**
  String get pledge_event;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;

  /// No description provided for @update_request.
  ///
  /// In en, this message translates to:
  /// **'Update Request'**
  String get update_request;

  /// No description provided for @add_request.
  ///
  /// In en, this message translates to:
  /// **'Add Request'**
  String get add_request;

  /// No description provided for @donation_type.
  ///
  /// In en, this message translates to:
  /// **'Donation Type'**
  String get donation_type;

  /// No description provided for @material_item.
  ///
  /// In en, this message translates to:
  /// **'Material Item'**
  String get material_item;

  /// No description provided for @monetary_amount.
  ///
  /// In en, this message translates to:
  /// **'Monetary Amount'**
  String get monetary_amount;

  /// No description provided for @item_name.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get item_name;

  /// No description provided for @delete_request.
  ///
  /// In en, this message translates to:
  /// **'Delete Request'**
  String get delete_request;

  /// No description provided for @delete_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this request?'**
  String get delete_confirmation;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @allevent.
  ///
  /// In en, this message translates to:
  /// **'All Event'**
  String get allevent;

  /// No description provided for @newpledge.
  ///
  /// In en, this message translates to:
  /// **'New Pledge'**
  String get newpledge;

  /// No description provided for @add_new_pledge.
  ///
  /// In en, this message translates to:
  /// **'Add New Pledge'**
  String get add_new_pledge;

  /// No description provided for @select_pledge.
  ///
  /// In en, this message translates to:
  /// **'Select Pledge'**
  String get select_pledge;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @report_event.
  ///
  /// In en, this message translates to:
  /// **'Report Event'**
  String get report_event;

  /// No description provided for @filter_event.
  ///
  /// In en, this message translates to:
  /// **'Filter Event'**
  String get filter_event;

  /// No description provided for @pick_date_range.
  ///
  /// In en, this message translates to:
  /// **'Pick Date Range'**
  String get pick_date_range;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @max_volunteer.
  ///
  /// In en, this message translates to:
  /// **'Max Volunteer'**
  String get max_volunteer;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @my_pledges.
  ///
  /// In en, this message translates to:
  /// **'My Pledges'**
  String get my_pledges;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @update_pledge.
  ///
  /// In en, this message translates to:
  /// **'Update Pledge'**
  String get update_pledge;

  /// No description provided for @delete_pledge.
  ///
  /// In en, this message translates to:
  /// **'Delete Pledge'**
  String get delete_pledge;

  /// No description provided for @delete_pledge_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the pledge and its associated data?'**
  String get delete_pledge_confirmation;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// No description provided for @birth_of_date.
  ///
  /// In en, this message translates to:
  /// **'Birth of Date'**
  String get birth_of_date;

  /// No description provided for @update_profile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get update_profile;

  /// No description provided for @total_hours.
  ///
  /// In en, this message translates to:
  /// **'Total hours'**
  String get total_hours;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @by_district.
  ///
  /// In en, this message translates to:
  /// **'By District'**
  String get by_district;

  /// No description provided for @registered_colon.
  ///
  /// In en, this message translates to:
  /// **'Registered: '**
  String get registered_colon;

  /// No description provided for @pledge.
  ///
  /// In en, this message translates to:
  /// **'Pledge'**
  String get pledge;

  /// No description provided for @already_registered.
  ///
  /// In en, this message translates to:
  /// **'You have already registered'**
  String get already_registered;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @new_pledge.
  ///
  /// In en, this message translates to:
  /// **'New pledge'**
  String get new_pledge;

  /// No description provided for @confirm_registration_process.
  ///
  /// In en, this message translates to:
  /// **'Confirm registration process'**
  String get confirm_registration_process;

  /// No description provided for @confirm_registration_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to register for this event?\n\nYou can withdraw before the event starts from the Event Management page.'**
  String get confirm_registration_message;

  /// No description provided for @event_management.
  ///
  /// In en, this message translates to:
  /// **'Event Management'**
  String get event_management;

  /// No description provided for @register_information.
  ///
  /// In en, this message translates to:
  /// **'Register information'**
  String get register_information;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @event_information.
  ///
  /// In en, this message translates to:
  /// **'Event information'**
  String get event_information;

  /// No description provided for @feedback_and_rating.
  ///
  /// In en, this message translates to:
  /// **'Feedback and rating'**
  String get feedback_and_rating;

  /// No description provided for @late_report.
  ///
  /// In en, this message translates to:
  /// **'Late Report'**
  String get late_report;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @withdraw_from_event.
  ///
  /// In en, this message translates to:
  /// **'Withdraw from Event'**
  String get withdraw_from_event;

  /// No description provided for @withdraw_from_event_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to withdraw from this event? Once withdrawn, you will not be able to register for this event again.'**
  String get withdraw_from_event_message;

  /// No description provided for @feedback_event.
  ///
  /// In en, this message translates to:
  /// **'Feedback Event'**
  String get feedback_event;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @late_report_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to file a late report?'**
  String get late_report_message;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @rate_not_zero.
  ///
  /// In en, this message translates to:
  /// **'Rating should be not zero'**
  String get rate_not_zero;

  /// No description provided for @qr_scanner.
  ///
  /// In en, this message translates to:
  /// **'Qr Scanner'**
  String get qr_scanner;

  /// No description provided for @event_name.
  ///
  /// In en, this message translates to:
  /// **'Event name'**
  String get event_name;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get user_name;

  /// No description provided for @resolution.
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get resolution;

  /// No description provided for @wallet_balance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get wallet_balance;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @method.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get method;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @no_data.
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get no_data;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
