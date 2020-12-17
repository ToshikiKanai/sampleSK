//
//  ViewController.swift
//  sampleSK
//
//  Created by 金井俊樹 on 2020/12/17.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    /*
    SKViewにSKSceneを追加していくことで画面の下地ができる(シンプルなゲームならSKView1つに対しSKSceneは1つ)
    SKSceneに各種Nodeを追加していくことでゲームができあがる
    ここではsetupParticle内でSKSceneの初期設定およびそれにNodeを追加しているが、SKSceneの初期設定とNodeの追加処理は分けた方が良さそう
 */
    var skView: SKView!
    var scene: SKScene!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SKViewの作成
            //SKViewのサイズ(CGRect)を設定。SKViewはただのviewなので、サイズを指定するだけで作成できる
        skView = SKView(frame: self.view.frame)
            //SKViewは透明か否か(基本true)
        skView.allowsTransparency = true
        //Scene追加
        setupParticle(size: self.view.frame.size)
    }
    
    //画面の向きが変わると呼ばれる
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //シーンの全ノード削除(多分allChildrenがシーンに含まれるノードのことだと思う)
        scene.removeAllChildren()
        
        //SKViewのサイズを再設定
        skView = SKView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        setupParticle(size: size)
    }
    
    //SKSceneの設定およびSKEmitterNodeの追加
    func setupParticle(size: CGSize){
        scene = SKScene(size: size)
        scene.backgroundColor = UIColor.clear
        
        //.sksファイルからSKEmitterNodeを作成
        let filePath = Bundle.main.path(forResource: "MyParticle", ofType: "sks")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let emitterParticleNode = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! SKEmitterNode

        //nodeに名前をつける。基本.sksdファイル名にしておけば良い
        emitterParticleNode.name = "MyParticle"
        emitterParticleNode.position = CGPoint(x: size.width / 2, y: size.height)
        emitterParticleNode.particlePositionRange = CGVector(dx: scene.size.width, dy: 1)
        emitterParticleNode.particleBlendMode = .add
        scene.addChild(emitterParticleNode)
        
        self.skView!.presentScene(scene)
        self.view.addSubview(self.skView!)
    }
    
}

