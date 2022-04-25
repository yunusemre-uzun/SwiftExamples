protocol ViewModelProtocol {
    var delegate: ViewController? { get }
}

class LeakedViewModel: ViewModelProtocol {
    var delegate: ViewController?
    
    deinit {
        print("deinit called for LeakedViewModel")
    }
}

class NotLeakedViewModel: ViewModelProtocol {
    weak var delegate: ViewController?
    
    deinit {
        print("deinit called for NotLeakedViewModel")
    }
}


class ViewController {
    var viewModel: ViewModelProtocol?
    
    init(viewModel: ViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    deinit {
        print("deinit called for view controller")
    }
}

// Given premises for having memory leak because of not using weak var

var leakedViewModel: LeakedViewModel? = LeakedViewModel()
var viewController: ViewController? = ViewController(viewModel: leakedViewModel)
leakedViewModel?.delegate = viewController

if leakedViewModel != nil && viewController != nil {
    print("leakedViewModel and viewController are created. Both are not nil")
}

// Then there shouldn't be a deinit log in the terminal for view controller.

// When set the view controller to nil
viewController = nil
print("viewController is set to be nil. it should removed from the memory unless there is a memory leak")

// Given premises for not having memory leak using weak var

viewController = ViewController(viewModel: leakedViewModel)
var notLeakedViewModel: NotLeakedViewModel? = NotLeakedViewModel()
notLeakedViewModel?.delegate = viewController
if notLeakedViewModel != nil && viewController != nil {
    print("notLeakedViewModel and viewController are created. Both are not nil")
}

// When set the view controller to nil
viewController = nil
print("viewController is set to be nil. it should removed from the memory unless there is a memory leak")

// Then there should be a deinit log in the terminal for view controller.
