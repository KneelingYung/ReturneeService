require('UIScreen,UIFont,UIImageView');
defineClass('tanChuBtn', {
            
            init: function() {
            self = self.super().init();
            if (self) {
            var widthLxy = UIScreen.mainScreen().bounds().width/375;
            var heightLxy = UIScreen.mainScreen().bounds().height/667;
            console.log("tetetetete4");
            var img = UIImageView.alloc().init();
            self.setIconImg(UIImageView.alloc().init());
            

            self.iconImg().setFrame({x:78.5*widthLxy, y:41*heightLxy, width:30.5*widthLxy, height:29*heightLxy});
            self.addSubview(self.iconImg());
            
            }
            return self;
            },
            
            
            
            
            layoutSubviews: function() {
            self.super().layoutSubviews();
            var widthLxy = UIScreen.mainScreen().bounds().width/375;
            var heightLxy = UIScreen.mainScreen().bounds().height/667;
            var  frame = {x:0, y:(41+29+8)*heightLxy, width:self.frame().width, height:15*heightLxy};
            self.titleLabel().setFrame(frame);
            self.titleLabel().setTextAlignment(1);
            self.titleLabel().setFont(UIFont.systemFontOfSize(15.0));

            },
            });
