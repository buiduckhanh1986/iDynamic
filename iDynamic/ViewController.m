//
//  ViewController.m
//  iDynamic
//
//  Created by Bui Duc Khanh on 6/27/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UIImageView *imgAnimal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Gán delegate cho txtSearch
    self.txtSearch.delegate = self;
}

// Tìm kiếm khi ấn nút tìm
- (IBAction)onButtonFindTouchUpInside:(id)sender {
    [self findAnimal];
}

// Tìm kiếm khi kết thúc gõ text bằng nút enter ( hàm implement cho UITextFieldDelegate )
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findAnimal];
    
    // 2 lệnh dưới để ẩn keyboard
    [textField resignFirstResponder];
    return YES; // want to hide keyboard
}

// Tìm ngay khi text thay đổi
- (IBAction)onTxtSearchEditingChanged:(id)sender {
    [self findAnimal];
}


// Hàm tìm kiếm và hiển thị ảnh
- (void) findAnimal{
    NSString* animal= self.txtSearch.text;
    Boolean findOK = false;
    
    // Kiểm tra nếu text không null và length > 0 thì mới tìm
    if (animal != nil && animal.length > 0)
    {
        //Các lớp cần tìm đều viết hoa chữ đầu còn lại là chữ thường nên xử lý lại string
        animal = [NSString stringWithFormat:@"%@%@",[[animal substringToIndex:1] uppercaseString],[[animal substringFromIndex:1] lowercaseString] ];
        
        // Tìm xem có lớp tương ứng không
        Class class = NSClassFromString(animal);
        
        if (class != nil) {
            id object = [class new];
            
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Wundeclared-selector"
            SEL getImageMethod = @selector(getImage);
            #pragma clang diagnostic pop
            
            // Có lớp tương ứng kiểm tra xem có hàm lấy ảnh tương ứng không
            if ([object respondsToSelector:getImageMethod]) {
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                // Lấy ảnh
                id result = [object performSelector:getImageMethod];
                
                // Gán ảnh
                findOK = true;
                [self.imgAnimal setImage:[UIImage imageNamed:result]];
                
                #pragma clang diagnostic pop
            }
        }
    }
    
    
    if (!findOK)
    {
        [self.imgAnimal setImage:[UIImage imageNamed:@"NotExists"]];
    }
}

@end
