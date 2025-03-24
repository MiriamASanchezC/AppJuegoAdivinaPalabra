//
//  ViewController.h
//  AppJuegoAdivinaPalabra
//
//  Created by Miriam Sanchez on 19/03/25.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *emojiLabel;

- (IBAction)comprobarPalabra:(id)sender;
- (IBAction)NewGame:(id)sender;


@end

