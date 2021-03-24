import UIKit

// Queue - Main, Global, Custom

// - Main
DispatchQueue.main.async {
    // UI update
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

// - Global Queue
DispatchQueue.global(qos: .userInteractive).async {
    // 진짜 핵 중요, 지금 당장 해야 하는 것
}
DispatchQueue.global(qos: .userInitiated).async {
    // 거의 바로 해줘야 할 것, 사용자가 결과를 기다림
}
DispatchQueue.global(qos: .default).async {
    // 이건 굳이?
}
DispatchQueue.global(qos: .utility).async {
    // 시간이 좀 걸리는 일들, 사용자가 당장 기다리지 않는 것, 네트워킹, 큰파일 불러올 때
}
DispatchQueue.global(qos: .background).async {
    // 사용자한테 당장 인식될 필요가 없는 것들, 뉴스데이터 미리 받기, 위치 업데이트,, 영상 다운받는 등
}

// - Custom Queue
let concurrenQueue = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)
let serialQueue = DispatchQueue(label: "serial", qos: .background)


// 복합적인 상황 (중요!)
func downloadImageFromServer() -> UIImage {
    // Heavy Task
    return UIImage()
}
func updateUI(image: UIImage) {
    
}

DispatchQueue.global(qos: .background).async {
    // download
    let image = downloadImageFromServer()
    
    // ui 관련 작업은 무조건 메인으로 넘겨서 작업하기!!!
    DispatchQueue.main.async {
        // update ui
        updateUI(image: image)
    }
}

// Sync, Async

// Async: 앞 작업이 다 끝나지 않아도 뒷 작업 시작 가능
DispatchQueue.global(qos: .background).async {
    for i in 0...5 {
        print("👍 \(i)")
    }
}
DispatchQueue.global(qos: .userInteractive).async {
    for i in 0...5 {
        print("🐽 \(i)")
    }
}

// Sync: 앞 작업이 다 끝나야 뒷 작업 가능 (뒷 작업 블락)
DispatchQueue.global(qos: .background).sync {
    for i in 0...5 {
        print("👍 \(i)")
    }
}
DispatchQueue.global(qos: .userInteractive).async {
    for i in 0...5 {
        print("🐽 \(i)")
    }
}
