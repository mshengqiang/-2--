//
//  DiaryViewController.m
//  UI_hot2动态时钟
//
//  Created by rimi on 16/1/20.
//  Copyright © 2016年 zhangshiiliang. All rights reserved.
//

#import "DiaryViewController.h"
#import "CustomCollectionViewCell.h"
#import <AVOSCloud/AVOSCloud.h>

@interface DiaryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UILabel    * _label1;
    UILabel    * _label2;
    UILabel    * _label3;
     NSIndexPath * _indexPath;
    
}

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray <UIImage *>* dataSource;

@property(nonatomic,strong)UITextView * textView;

@property(nonatomic,strong)NSArray * arrColor;
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,strong)UILabel * count;
@property(nonatomic,retain,readonly)UISlider *slider1;
@property(nonatomic,retain,readonly)UISlider *slider2;
@property(nonatomic,retain,readonly)UISlider *slider3;

@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)UIButton * button2;
@property(nonatomic,strong)UIButton * button3;
@property(nonatomic,strong)NSString * string1;
@property(nonatomic,strong)NSString * string2;
@property(nonatomic,strong)UIImageView * addImage;
@property(nonatomic,retain)NSMutableArray * pictures;
@property (nonatomic,retain)NSString * urlString;
-(void)initUserInterface;
-(void)saveButtonPressed:(UIButton *)sender;
@end

@implementation DiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    [self initDataSource];
    [self initUserInterface];
    
    
    
}
-(void)initDataSource{
    
    
    _dataSource = [[NSMutableArray alloc]init];
    
    [_dataSource addObject:self.addImage.image];

}
-(void)initUserInterface{
    
    self.collectionView.frame = CGRectMake(0, 400, self.view.bounds.size.width, 230);
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.collectionView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"写动态";
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(savenButtonPressed:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 130, self.view.frame.size.width - 40, 30)];
    
    //预设文本
    self.textView.text = @"...";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name: UITextViewTextDidChangeNotification object:nil];
    //    NSString
    //    * desc = @"Description it is  a test font, and don't become angry for which i use to do here.Now here is a very nice party from american or not!";
    //    CGSize size = [desc sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(240, 2000) lineBreakMode:UILineBreakModeWordWrap];
    //文本对齐方式
    self.textView.textAlignment = NSTextAlignmentLeft;
    //文本颜色
    self.textView.textColor = [UIColor blackColor];
    //设置字体名字和字体大小
    self.textView.font
    = [UIFont fontWithName:@"Arial" size:18.0];
    //文本框背景颜色
    self.textView.backgroundColor = [UIColor lightGrayColor];
    //边框颜色
    self.textView.layer.borderColor = [UIColor redColor].CGColor;
    //圆角
    self.textView.layer.cornerRadius = 5.0;
    self.textView.delegate = self;
    
    //修复文本框下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    //是否可拖动
    self.textView.scrollEnabled = YES;
    [self.view addSubview:self.textView];

}

-(void)takeCamera{
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        NSLog(@"该设备不支持相机");
        return;
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    //数据源
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //是否允许编辑
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)takePhotos{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    //数据源
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //是否允许编辑
    picker.allowsEditing = YES;
    //<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark -- collectonViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
       return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdf" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"and"]];
    //存相应的图片 取字典中的keys  √*******************************VVVVVVVVVVV
    cell.imageView.image = self.dataSource[indexPath.item];
    return cell;
}
//头部视图 底部视图 附加视图 儿子在上面
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //头头是道
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hederIdf" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor grayColor];
        return reusableView;
        //娓娓道来
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerIdf" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor lightGrayColor];
        return reusableView;
    }
    return nil;
}
#pragma mark -- collectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相机
        [self takeCamera];
    }];
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"相册"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                               //打开相册
                                                               [self takePhotos];
                                                           }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    [alert addAction:photoAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -- imagePicker delegat
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    CustomCollectionViewCell * cell = (CustomCollectionViewCell *)[self.collectionView  cellForItemAtIndexPath:_indexPath];
    //添加图片
    cell.imageView.image = info[UIImagePickerControllerEditedImage];
    
    [self.dataSource addObject:cell.imageView.image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    [self.dataSource addObject:self.addImage.image];
    [self.collectionView reloadData];
    NSLog(@"self.datasource = %@",self.dataSource);
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //右上角的
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 自适应大小
-(void)textChanged:(NSString *)text{
    int textl = (int)self.textView.text.length / 44;
    int texty = (int)self.textView.text.length % 44;
    if (texty != 0) {
        textl = textl + 1;
    }
    if (self.textView.text.length == 0) {
        textl = 1;
    }
    CGRect frame = self.textView.frame;
    frame.size.height = textl * 30  ;    
    self.textView.frame = frame;
}
- (void)dismissKeyBoard {
    [self.textView resignFirstResponder];
    //    NSLog(@"%@",self.textView.text);
    
}
#pragma mark -- 发布
-(void)savenButtonPressed:(UIButton *)sender{
    [self dismissKeyBoard];

    NSString * str = self.textView.text;
    if ([str isEqualToString:@""] || [str isEqualToString:@"..."]) {
        return;
    }
    if (self.textBlock) {
        self.textBlock(str);
    }
    _pictures = [NSMutableArray array];
    
    AVObject * add = [AVObject objectWithClassName:@"Square"];
    [add setObject:self.textView.text forKey:@"chat1"];
    
//  用户昵称 本地化
    NSString * userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    [add setObject:@"张世亮" forKey:@"Who"];

    

    for (int i = 1; i < _dataSource.count; i ++) {
       
        NSData * imagedata = UIImageJPEGRepresentation(_dataSource[i], 0.6);
        AVFile * file = [AVFile fileWithName:@"pict" data:imagedata];
        
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (succeeded) {

                _urlString = file.url;
                [_pictures addObject:_urlString];
                NSLog(@"-------------------%@ %@ %@", _pictures,_urlString,imagedata);
                [add setObject:_pictures forKey:@"pictures"];
                [add save];
            }
            
            
        }];
    }

    NSLog(@"_pictures = %@",_pictures);


    
    
}


#pragma mark -- Getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
            
            //初始化 流程布局
            UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc]init];
            layOut.minimumLineSpacing = 10;
            layOut.minimumInteritemSpacing = 10;
            layOut.itemSize = CGSizeMake(120, 120);
            
            
//            layOut.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 10);
//            layOut.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 10);
            
            UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layOut];
            
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            //内边距
            collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
            //使用XIB
            [collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellIdf"];
            
            //            [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdf"];
            
            //头头是道
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hederIdf"];
            //尾尾道来
            [collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerIdf"];
            
            collectionView;
        });
    }
    return _collectionView;
}
-(UIImageView *)addImage{
    if (!_addImage) {
        _addImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        [_addImage setImage:[UIImage imageNamed:@"and.png"]];
    }
    return _addImage;
}


@end

