//
//  SetUserViewController.m
//  Product_B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 H. All rights reserved.
//

#import "SetUserViewController.h"

@interface SetUserViewController ()<UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UIPickerView *gender;


@property (strong, nonatomic) IBOutlet UIDatePicker *birthday;

@property (strong, nonatomic)UIAlertController *alertController;
@property (strong, nonatomic)UIImagePickerController *imagePicker;

@property (strong, nonatomic)UIImage *iconImage;
@property (assign, nonatomic)NSInteger genderValue;
@end

@implementation SetUserViewController

- (UIImagePickerController *)imagePicker{
    
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.allowsEditing = YES;
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.genderValue = 1; // 默认为男
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row == 0) {
        return @"男";
    }else{
        return @"女";
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.genderValue = row + 1;
    
}

#pragma mark ---点解头像按钮---
- (IBAction)iconImage:(UIButton *)sender {
    
    [self alertChoosePick];
    
    
}


#pragma mark ---弹出选择照片----

- (void)alertChoosePick{
    self.alertController = [UIAlertController alertControllerWithTitle:@"设置头像" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *photoAlert = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.alertController dismissViewControllerAnimated:NO completion:nil];
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cameraAlert = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.alertController dismissViewControllerAnimated:NO completion:nil];
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self.alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self.alertController addAction:photoAlert];
    }
    
    if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.alertController addAction:cameraAlert];
    }
    [self.alertController addAction:cancel];
    [self presentViewController:self.alertController animated:YES completion:nil];
}




#pragma mark ---实现调用相册的代理----

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //
    UIImage *image = info[UIImagePickerControllerEditedImage];
    // 将图片转化成小尺寸
    // 获取原图片的比例
    CGFloat aspect =  image.size.width / image.size.height;
    self.iconImage = [self changeImage:image toSize:CGSizeMake(200 * aspect, 200)];
    
    [self.iconButton setImage:nil forState:(UIControlStateNormal)];
    [self.iconButton setBackgroundImage:image forState:(UIControlStateNormal)];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark ---更改图片大小-----

- (UIImage *)changeImage:(UIImage *)image toSize:(CGSize)size{
    
    // 首先建立image绘制层
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark ---提交更改信息按钮-----
- (IBAction)commitButton:(UIButton *)sender {
    
    // 获取生日
    NSDate *date = self.birthday.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateString = [formatter stringFromDate:date];
    NSArray *dateArray = [dateString componentsSeparatedByString:@"."];
    
    // 1. 提交上传图片, 上传表单
    AFHTTPSessionManager *afManager = [AFHTTPSessionManager manager];
    afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [afManager POST:@"http://api.breadtrip.com/accounts/upload_avatar/" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImagePNGRepresentation(self.iconImage);
        
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%f", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
    
    // 2.提交更改性别, 生日的请求
    NSString *urlString = @"http://web.breadtrip.com/accounts/settings/basic_info/";
    NSDictionary *parDic = @{@"url": @"",
                             @"gender": @(self.genderValue),
                             @"birthday_y": dateArray[0],
                             @"birthday_m": dateArray[1],
                             @"birthday_d": dateArray[2],
                             @"link": @"",
                             @"bio": @""
                             };
    [RequestManager requestManager:urlString requestType:(RequestPOST) queryDictionary:parDic finish:^(NSData *data) {
        
        NSString *htmlString = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
        NSLog(@"");
        
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel* pickerLabel = (UILabel*)view;
//    if (!pickerLabel){
//        pickerLabel = [[UILabel alloc] init];
//        // Setup label properties - frame, font, colors etc
//        //adjustsFontSizeToFitWidth property to YES
//        pickerLabel.contentMode = UIViewContentModeLeft;
//        [pickerLabel setBackgroundColor:[UIColor clearColor]];
//        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
//    }
//    // Fill the label text here
//    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
//    return pickerLabel;
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
