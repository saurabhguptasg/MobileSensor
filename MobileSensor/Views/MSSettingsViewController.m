//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSSettingsViewController.h"
#import "WidgetManager.h"
#import "MSSensorUtils.h"
#import "MSDataManager.h"
#import "UIImage+MobileSensor.h"
#import "MSNetworkManager.h"


@implementation MSSettingsViewController {
@private
    WidgetManager *_widgetManager;
    UITextField *endpointField;
    UIButton *endpointCancelButton;
    UIButton *endpointSaveButton;
    NSString *prevEndpointText;
    NSMutableArray *cells;

    UISwitch *backgroundSwitch;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _widgetManager = [WidgetManager instance];
        cells = [[NSMutableArray alloc] init];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    prevEndpointText = [[MSDataManager instance] getEndpoint];
    [self buildCells];
}

-(void) buildCells {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];

    [self.navigationItem setTitle:NSLocalizedString(@"Settings", @"")];

    UITableViewCell *deviceIdCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"uuid"];
    deviceIdCell.textLabel.text = [[MSDataManager instance] getUUID];
    deviceIdCell.detailTextLabel.text = NSLocalizedString(@"Device Id", @"");
    [cells addObject:deviceIdCell];

    CGSize screenSize = [[MSSensorUtils instance] screenSize];
    UITableViewCell *endpointLabelCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:@"endpointLabel"];
    endpointLabelCell.textLabel.text = NSLocalizedString(@"Endpoint:", @"");
    endpointLabelCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cells addObject:endpointLabelCell];

    endpointField = [[UITextField alloc] initWithFrame:CGRectMake(endpointLabelCell.separatorInset.left, 2.0f, screenSize.width - endpointLabelCell.separatorInset.left - 5.0f, 40.0f)];
    endpointField.layer.cornerRadius = 5.0f;
    endpointField.layer.masksToBounds = YES;
    endpointField.layer.shadowRadius = 5.0f;
    endpointField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    endpointField.keyboardType = UIKeyboardTypeURL;
    endpointField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.66];
    endpointField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,5,40)];
    endpointField.leftViewMode = UITextFieldViewModeAlways;
    endpointField.rightView = [[UIView alloc] initWithFrame:CGRectMake(endpointField.frame.size.width - 5,0,5,40)];
    endpointField.rightViewMode = UITextFieldViewModeAlways;
    endpointField.text = prevEndpointText;
    endpointField.delegate = self;
    UITableViewCell *endpointFieldCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:@"endpointField"];
    endpointFieldCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [endpointFieldCell addSubview:endpointField];
    [cells addObject:endpointFieldCell];

    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(5, 5, screenSize.width - 10, 44)];
    toolbar.backgroundColor = [UIColor clearColor];
    toolbar.barTintColor = [UIColor whiteColor];
    toolbar.clipsToBounds = YES;
    UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                target:nil action:nil];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(endpointCancel:)];
    UIBarButtonItem *midSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                  target:nil
                                                                                  action:nil];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                              target:self
                                                                              action:@selector(endpointSave:)];
    toolbar.items = @[leftSpacer, cancelItem, midSpaceItem, saveItem];

    UITableViewCell *saveCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:@"endpointSave"];
    saveCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [saveCell addSubview:toolbar];
    [cells addObject:saveCell];

    backgroundSwitch = [[UISwitch alloc] init];
    [backgroundSwitch addTarget:self
                         action:@selector(handleBGSwitch:)
               forControlEvents:UIControlEventValueChanged];
    UITableViewCell *bgCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:@"backgroundSwitch"];
    bgCell.textLabel.text = NSLocalizedString(@"Background Data Collection", @"");
    bgCell.accessoryView = backgroundSwitch;
    [cells addObject:bgCell];
}

- (void)endpointSave:(id)endpointSave {
    [[MSDataManager instance] setEndpoint:endpointField.text];
    prevEndpointText = endpointField.text;
}

- (void)endpointCancel:(id)endpointCancel {
    endpointField.text = prevEndpointText;
}

-(void)handleBGSwitch:(id)sender {
    NSLog(@"backgroundSwitch.isOn = %d", backgroundSwitch.isOn);
}

-(void)dismissKeyboard:(UITextField *)textField {
    [endpointField resignFirstResponder];
}

#pragma mark - TableViewController delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cells[indexPath.item];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cells.count;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}
*/

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



@end