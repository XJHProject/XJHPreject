//热修复、、
defineClass('XJH_FourViewController', {
  rightAction: function() {
    var tableViewCtrl = VideoListViewController.alloc().init()
    self.navigationController().pushViewController_animated(tableViewCtrl, YES)
  }
})
