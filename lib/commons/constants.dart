// ignore_for_file: always_specify_types

class Constants {
  static const String EVENT_PERIOD_TYPE = 'EVENT_PERIOD_TYPE';
  static const String ENROLLMENT_DATE_UID = 'ENROLLMENT_DATE_UID';
  static const String ENROLLMENT_DATE = 'enrollmentDate';
  static const String INCIDENT_DATE = 'incidentDate';
}

// const String kApiBaseUrl = 'https://api.nmcpye.org';
// const String kApiBaseUrl = 'https://play.nmcpye.org';
// const String kApiBaseUrl = 'http://10.0.2.2:8080'; // Vm network
// const String kApiBaseUrl = 'http://192.168.8.110:8080'; // hNet
// const String kApiBaseUrl = 'http://192.168.137.1:8080'; // mobile hotspot
const String kApiBaseUrl = 'http://192.168.80.1:8080'; // hNet


const String kAppVersion = 'v1.0.0';
const String kAppName = 'Flutter Examples';
// final kAppIcon =
// Image.asset('res/images/launcher_icon.png', height: 64.0, width: 64.0);
const String kAppProductionUrl = 'https://nmcpye.org';
const String kAppStagingUrl = 'https://staging.nmcpye.org';
const String kAppLargeTestUrl = 'https://testv5.nmcpye.org';
const String kAppDemoUrl = 'https://demo.nmcpye.org';

// Shared Prefs
const String kSharedPrefs = 'shared_prefs';
const String kSharedPrefUrl = 'url';
const String kSharedPrefToken = 'checksum';

// routes
const String kMain = 'main';
const String kSettings = 'settings';
const String kDashboard = 'dashboard';
const String kReports = 'reports';

// Paths
const String kGooglePlayUrl = '';
const String kGitHubUrl = 'https://github.com/Hamza-ye/flutter_examples';
const String kCoverageReportsPath = 'coverage-reports';
const String kCoverageDataItemsPath = 'coverage-data_items';
const String kTeamsPath = 'teams';
const String kTargetsPath = 'targets';
const String kChvMalariaCasesPath = 'chv-malaria-cases';
const String kOrgUnitApiPath = 'organisation-units';
const String kStockTypeApiPath = 'stock-items';
const String kUserApiPath = 'account';
const String kUserGroupApiPath = 'user-groups';
const String kPeopleApiPath = 'user-data';
const String kUserAuthGroupApiPath = 'user-authority-groups';
const String kChvApiPath = 'chvs';
const String kChvTeamApiPath = 'chv-teams';
const String kAuthenticationApiPath = 'authenticate';
const String kSignupApiPath = 'signup';

// Hive Boxes
const String kChvMalariaCasesBoxName = 'chv_malaria_cases_box';
const String kOrgUnitsBoxName = 'org_units_box';
const String kStockTypesBoxName = 'stock_types_box';
const String kChvInfoBoxName = 'chv_info_box';
const String kUserInfoBoxName = 'user_info_box';
const String kCPeopleInfoBoxName = 'people_info_box';

// Theme
const String kColorThemeLight = 'light';
const String kColorThemeDark = 'dark';

const double kGutterWidth = 16;
const double kLighterOpacity = .6;

// Layout
const double kBorderRadius = 2;
const double kMobileLayoutWidth = 700;
const double kMobileDialogPadding = 12;
const double kDrawerWidthMobile = 272;
const double kDrawerWidthDesktop = 210;
const double kTableColumnGap = 16;
const double kTopBottomBarHeight = 50;
const double kDialogWidth = 400;
const double kDashboardPanelHeight = 543; // TODO(Old): remove this
const double kDashboardPanelHeightWeb = 539; // TODO(Old): remove this
const double kListNumberWidth = 100;

const double kTabletLayoutWidth = 1100;
const double kTabletDialogPadding = 250;

const double kTableColumnWidthMin = 20;
const double kTableColumnWidthMax = 150;

const int kTableListWidthCutoff = 550;
const int kDefaultAnimationDuration = 500;

const String kDefaultCurrencyId = '1';
const String kDefaultDateFormat = '5';
const String kDefaultAccentColor = '#2F7DC3';
const String kDefaultDarkSelectedColorMenu = '#1E252F';
const String kDefaultDarkSelectedColor = '#253750';
const String kDefaultDarkBorderColor = '#393A3C';
const String kDefaultLightSelectedColorMenu = '#f2faff';
const String kDefaultLightSelectedColor = '#e5f5ff';
const String kDefaultLightBorderColor = '#dfdfdf';

const int kMaxPostSeconds = 60;
const int kMaxRawPostSeconds = 300;
const int kMaxEntitiesPerBulkAction = 100;
const int kHostedRecordsPerPage = 20000;
const int kSelfhostedRecordsPerPage = 5000;
const int kMillisecondsToTimerRefreshData = 1000 * 60 * 5; // 5 minutes
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes
const int kUpdatedAtBufferSeconds = 600;
const int kMillisecondsToRefreshActivities = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToRefreshStaticData = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToDebounceUpdate = 500; // .5 second
const int kMillisecondsToDebounceSave = 1500; // 1.5 seconds
const int kMillisecondsToDebounceWrite = 3000; // 3 seconds

const String kEntityStateSynced = 'synced';
const String kEntityStateDraft = 'draft';
const String kEntityStateCompleted = 'completed';
const String kEntityStateNotCompleted = 'notCompleted';
const String kEntityStateUnSyncable = 'UnSyncable';

const String kFieldTypeSingleLineText = 'single_line_text';
const String kFieldTypeMultiLineText = 'multi_line_text';
const String kFieldTypeDropdown = 'dropdown';
const String kFieldTypeDate = 'date';
const String kFieldTypeSwitch = 'switch';

const String kSwitchValueYes = 'yes';
const String kSwitchValueNo = 'no';

const String kNotificationChannelEmail = 'email';
const String kNotificationChannelSlack = 'slack';

const String kPlatformWindows = 'Windows';
const String kPlatformLinux = 'Linux';
const String kPlatformMacOS = 'macOS';
const String kPlatformAndroid = 'Android';
const String kPlatformiPhone = 'iPhone';

const String kAppleStoreUrl =
    'https://apps.apple.com/us/app/nmcp-ye-v5/kAppStoreAppId';
const String kGoogleStoreUrl =
    'https://play.google.com/store/apps/details?id=kPlayStoreAppId';
const String kGoogleFDroidUrl = 'https://f-droid.org/packages/com.nmcpye.app';
const String kMacOSUrl = 'https://apps.apple.com/app/id1503970375';
const String kLinuxUrl = 'https://snapcraft.io/iccmyemen';
const String kWindowsUrl =
    'https://www.microsoft.com/en-us/p/iccm-yemen/kMicrosoftAppStoreId';

const String kDebugModeUrl =
    'https://www.mailgun.com/blog/a-word-of-caution-for-laravel-developers';
const String kCapterralUrl = 'https://www.capterra.com/p/145215/mass_pro';
const String kCronsHelpUrl =
    'https://iccmyemen.github.io/docs/self-host-troubleshooting/#cron-not-running-queue-not-running';
const String kGitHubDiffUrl =
    'https://github.com/iccmyemen/iccmyemen/compare/vVERSION...v5-stable';
const String kGitHubLangUrl =
    'https://github.com/iccmyemen/iccmyemen/blob/master/resources/lang/en/texts.php';
const String kStatusCheckUrl = 'https://status.nmcpye.com/';
const String kGoogleAnalyticsUrl =
    'https://support.google.com/analytics/answer/1037249?hl=en';

const String kEntityStatusDraft = '1';
const String kEntityStatusSynced = '2';
const String kEntityStatusCompleted = '3';
const String kEntityStatusUncompleted = '4';
const String kEntityStatusUnSynchronizable = '5';

const Map<String, String> kChvMalariaCaseStatuses = {
  kEntityStatusDraft: 'draft',
  kEntityStatusSynced: 'sent',
  kEntityStatusCompleted: 'completed',
  kEntityStatusUncompleted: 'uncompleted',
};

const Map<String, String> kGenders = {
  'MALE': 'MALE',
  'FEMALE': 'FEMALE',
};

const Map<String, String> kMalariaTestResult = {
  'NEGATIVE': 'NEGATIVE',
  'PF': 'PF',
  'PV': 'PV',
  'MIX': 'MIX',
  'INVALID': 'INVALID',
};

const Map<String, String> kMalariaSeverity = {
  'SIMPLE': 'SIMPLE',
  'SEVERE': 'SEVERE',
};

const String kDrawerKey = 'drawer_key';
const String kSelectCompanyDropdownKey = 'select_company_dropdown_key';

const String kAppStateStorageKey = 'appStateKey';
const String kUIStateStorageKey = 'uiStateKey';
const String kUserAppStateStorageKey = 'userAppStateKey';
const String kAccountStorageKey = 'accountKey';
const String kAuthStateStorageKey = 'authStateKey';
const String kPrefStateStorageKey = 'prefStateKey';

const List<String> kLanguages = [
  'en',
  'ar',
];

const String kSettingsUserDetails = 'user_details';
const String kSettingsDeviceSettings = 'device_settings';
const String kSettingsUserManagement = 'user_management';
const String kSettingsUserManagementView = 'user_management/view';
const String kSettingsUserManagementEdit = 'user_management/edit';
const String kSettingsAccountManagement = 'account_management';
const String kSettingsImportExport = 'import_export';

// EVENT_CREATION
const String PREVIOUS_DASHBOARD_PROGRAM = 'previous_dashboard_program';
const String PROGRAM_THEME = 'PROGRAM_THEME';
const String SERVER = 'SERVER';
const String THEME = 'THEME';
const String DATA_SET_UID = 'DATA_SET_UID';
const String DATA_SET_NAME = 'DATA_SET_NAME';
const int DESCRIPTION_DIALOG = 111;
const String PERIOD_TYPE = 'PERIOD_TYPE';
const String PERIOD_ID = 'PERIOD_ID';
const String PERIOD_TYPE_DATE = 'PERIOD_TYPE_DATE';
const String CAT_COMB = 'CAT_COMB';
const String DEFAULT_CAT_COMBO = 'DEFAULT_CAT_COMB';
const String DATA_SET_SECTION = 'DATA_SET_SECTION';
const String PROGRAM_STAGE_UID = 'PROGRAM_STAGE_UID';
const int RQ_MANDATORY_EVENTS = 2001;
const String OPTION_SET_DIALOG_THRESHOLD = 'optionSetDialogThredshold';
const String USER_TEST_ANDROID = 'android';
const String USER = 'USER';
const String USER_ASKED_CRASHLYTICS = 'USER_ACCEPT_CRASHLYTICS';
const String ENROLLMENT_STATUS = 'ENROLLMENT_STATUS';

const String SYNC_RESULT = 'sync_result';
const String LAST_DATA_SYNC = 'last_data_sync';
const String LAST_DATA_SYNC_STATUS = 'last_data_sync_status';
const String LAST_META_SYNC = 'last_meta_sync';
const String LAST_META_SYNC_STATUS = 'last_meta_sync_status';
const String LAST_META_SYNC_NO_NETWORK = 'last_meta_sync_no_network';
const String EVENT_UID = 'EVENT_UID';
const String EVENT_MODE = 'EVENT_MODE';
const String EVENT_CREATION_TYPE = 'EVENT_CREATION_TYPE';

const String RECORDS = 'RECORDS';
const String SYNCABLE_CREATION_TYPE = 'SYNCABLE_CREATION_TYPE';
const String SYNCABLE_UID = 'SYNCABLE_UID';
const String FORM_UID = 'FORM_UID';
const String FORM_VERSION = 'FORM_VERSION';
const String FORM_CODE = 'FORM_CODE';
const String TEAM_UID = 'TEAM_UID';
const String ACTIVITY_UID = 'ACTIVITY_UID';

const String EVENT_SCHEDULE_INTERVAL = 'EVENT_SCHEDULE_INTERVAL';
const String TRACKED_ENTITY_INSTANCE = 'TRACKED_ENTITY_INSTANCE';
const String PROGRAM_UID = 'PROGRAM_UID';
const String ORG_UNIT = 'ORG_UNIT';
const String ORG_UNIT_NAME = 'ORG_UNIT_NAME';
const String ONE_TIME = 'ONE_TIME';
const String PERMANENT = 'PERMANENT';
const String ENROLLMENT_UID = 'ENROLLMENT_UID';
const String EVENT_REPEATABLE = 'EVENT_REPEATABLE';
const String EVENT_PERIOD_TYPE = 'EVENT_PERIOD_TYPE';
const String ENROLLMENT_DATE_UID = 'ENROLLMENT_DATE_UID';
const String ENROLLMENT_DATE = 'enrollmentDate';
const String INCIDENT_DATE = 'incidentDate';

// Note
const String NOTE_ID = 'NOTE_ID';
const String NOTE_TYPE = 'NOTE_TYPE';

// AnalyticsConstants
const String DATA_TIME = 'data_time';
const String METADATA_TIME = 'metadata_time';

// Sync Output

