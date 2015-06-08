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
    CGSize screenSize = [[MSSensorUtils instance] screenSize];
    UITableViewCell *endpointLabelCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:@"endpointLabel"];
    endpointLabelCell.textLabel.text = @"Endpoint:";
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
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                              target:self
                                                                              action:@selector(endpointSave:)];
    toolbar.items = @[leftSpacer, cancelItem, saveItem];

    UITableViewCell *saveCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:@"endpointSave"];
    saveCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [saveCell addSubview:toolbar];
    [cells addObject:saveCell];
}

- (void)endpointSave:(id)endpointSave {
    [[MSDataManager instance] setEndpoint:endpointField.text];
    [[MSNetworkManager instance] setTransmitUrl:endpointField.text];
    prevEndpointText = endpointField.text;
}

- (void)endpointCancel:(id)endpointCancel {
    endpointField.text = prevEndpointText;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cells[indexPath.item];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}


@end