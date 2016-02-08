//
//  ViewController.m
//  HttpRequests
//
//  Created by hussien alrubaye on 2/7/16.
//  Copyright © 2016 hussien alrubaye. All rights reserved.
//

#import "ViewController.h"
#import "ViewControler2.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *laUserName;
@property (weak, nonatomic) IBOutlet UILabel *LAMessage;
@property (weak, nonatomic) IBOutlet UITextField *LaPassword;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  self.searchBar.delegate   = self;
   // self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buClick:(id)sender {
   
    [self httpRequest];
 
   
}


-(void)httpRequest{
    NSString *myurl=[NSString stringWithFormat:@"http://selling.alruabye.net/UsersWS.asmx/Login?UserName=%@&Password=%@",_laUserName.text, _LaPassword.text];
    NSURL *URL = [NSURL URLWithString:myurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // return data
                                      NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                      //calll interface
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          NSString *Message=  [parsedObject objectForKey:@"Message"] ;
                                          if (Message.length>0 ) {
                                              _LAMessage.text=Message;}
                                          else{
                                              ViewControler2 *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControler2"];
                                              [self presentViewController:monitorMenuViewController animated:NO completion:nil];
                                              
                                          }
                                      });
                                      
                     

                                  }];
                       [task resume];
  

}



@end
