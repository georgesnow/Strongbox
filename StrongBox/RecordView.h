//
//  RecordView.h
//  StrongBox
//
//  Created by Mark on 31/05/2017.
//  Copyright © 2017 Mark McGuill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"
#import "Model.h"

@interface RecordView : UITableViewController <UITextViewDelegate>

@property (nonatomic, strong, nullable) Node *record;
@property (nonatomic, strong, nullable) Node *parentGroup;
@property (nonatomic, strong, nonnull) Model *viewModel;

@property (weak, nonatomic, nullable) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic, nullable) IBOutlet UITextView *textViewNotes;
@property (weak, nonatomic, nullable) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic, nullable) IBOutlet UITextField *textFieldUsername;
@property (weak, nonatomic, nullable) IBOutlet UITextField *textFieldUrl;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonHidePassword;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonGeneratePassword;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonCopyUsername;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonCopyUrl;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonCopyAndLaunchUrl;
@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonCopyEmail;

@property (strong, nonatomic) IBOutlet UIButton * _Nullable buttonHistory;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellAttachments;
@property (weak, nonatomic) IBOutlet UILabel *labelCustomFieldsCount;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellCustomFields;

@property (weak, nonatomic, nullable) IBOutlet UIButton *buttonPasswordGenerationSettings;

- (IBAction)onGenerateOrCopyPassword:(id _Nullable )sender;
- (IBAction)onCopyUsername:(id _Nullable)sender;
- (IBAction)onCopyUrl:(id _Nullable)sender;
- (IBAction)onHide:(id _Nullable)sender;
- (IBAction)onCopyAndLaunchUrl:(id _Nullable)sender;
- (IBAction)onCopyEmail:(id _Nullable)sender;

@end
