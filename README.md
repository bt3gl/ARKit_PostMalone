# 🎈 AR Post Malone 🎈


[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)


*Augmented reality (AR) describes user experiences that add 2D or 3D elements to the live view from a device’s camera in a way that makes those elements appear to inhabit the real world.*


I am going to show how neat is to write an AR iOS application with [ARKit](https://developer.apple.com/arkit/), a framework that provides you high level classes for **tracking**, **scene understanding** and **rendering**. More specifically, ARKit is a session based framework. This means that everything will happen in a concrete session. The session relates the virtual objects with the real world by means of the Tracking.

This app runs an ARKit world tracking session with content displayed in a [SpriteKit](https://developer.apple.com/documentation/spriteKit) 2D view. Every session has a scene that will render the virtual objects in the real world, accessed by means of the iOS device sensors.


<img src="https://github.com/bt3gl/AR_PostMalone/blob/master/screenshots/post_1.jpeg" width="200"> <img src="https://github.com/bt3gl/AR_PostMalone/blob/master/screenshots/post_2.PNG" width="200"> <img src="https://github.com/bt3gl/AR_PostMalone/blob/master/screenshots/post_3.PNG" width="200">



## Running


* This app has been successfully tested on Xcode 9.4 + iOS 11.4.
* When running it in your device, simply click on where you want to see Post Malone. Then click again to explode it out! 😎



## Undestanding the SourceCode


### `Info.plist`

An information property list file is a XML file that contains essential configuration information for a bundled executable. Example of the information you want to add is:

* The name of your app (`<string>PostMaloneBalloon</string>`).
* Camera usage (`<key>NSCameraUsageDescription</key>`).
* Frameworks you need (`<key>UIRequiredDeviceCapabilities</key>` with `<string>armv7</string>` and `<string>arkit</string>`).


### `Assets.xcassets` directory

This is where you place assets such as the images used in your App (Post Malone head) and icons. A file `Content.json` is placed inside every directory to describe the assets.

### `Base.lproj` directory

Contains two [story board files](https://www.raywenderlich.com/160521/storyboards-tutorial-ios-11-part-1):

* `LaunchScreen.storyboard`.
* `Main.storyboard`.



### `Scene.swift`

Anchors are 3D points that correspond real world features that ARKit detects. This class is where the anchor is created, and also manages the Sprite scene (Scene.sks). This module is where you call the class `Scene` to control how the App is operating with the scene. Rendering brings tracking and scene understanding together with your content.

For our App, we are:

* Defining the method `touchesBegan`, where we define what happens when we click the scene.
* The sequence of movements is defined by `let sequence = SKAction.sequence([popSound, moveDown, moveDownFloating, moveToBottom])`.
* When you touch the scene, a Post Malone Balloon head appears and starts to behave as a balloon (`moveDownFloating = ((arc4random() % 2)==0) ? moveLeftDown : moveRightDown`).
* The balloon either pops (`let popSound = SKAction.playSoundFileNamed("pop", waitForCompletion: false)`) or fades after a second (`fadeOut = SKAction.fadeOut(withDuration: 1.0)`).
* An ARAnchor uses a 4×4 matrix represents the combined position, rotation or orientation, and scale of an object in three-dimensional space (as in `var translation = matrix_identity_float4x4`).


### `ViewController.swift`

This view is managed by the class ViewController, which inherents from `ARSKViewDelegate` so that we can create a `sceneView` variable. This class has methods for:

* Views
    - Scaling and placing the view.
    - View when it loads (and load the pre-defined scene from [SKScene](https://developer.apple.com/documentation/spritekit/skscene)).
    - View to appear and disappear.
    - Run.

* Sessions
    - Session interrupted.
    - Session ended.



### `AppDelegate.swift`

This is where we call the class `AppDelegate`, which responds for `UIApplicationMain`. In this class we create a variable that will work as the window UI and we have UI methods for:

* See if the application is about to move from active to inactive state (for example, pause ongoing tasks).
* Release shared resources and  save user data.
* Change from the background to the active state.
* Restart any tasks that were paused while the application was inactive.
* Termination actions for when the application is about to terminate (for example, to save data if appropriate).



------



# Some Learning References

## Augmented Reality

### AR Platforms

* [ARKit Developer Portal (Apple)](https://developer.apple.com/arkit/):  Apple’s developer portal for ARKit.
* [ARCore Developer Portal (Google)](https://developers.google.com/ar/):  Google’s developer portal for ARCore.
* [AR Studio (Facebook)](https://developers.facebook.com/docs/ar-studio): Facebook's tools.
* [ViroAR for ARKit and ARCore](https://viromedia.com/viroar).

### Quintessential Readings

* [Apple's Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/augmented-reality/).
* [The State of Mobile AR: A Platform Overview](https://render.betaworks.com/the-state-of-mobile-ar-a-platform-overview-9f8cd9ec91f4).
* [AR-First Mobile second](https://medium.com/6d-ai/ar-first-mobile-second-614e85673083).
* [How is ARCore better than ARKit](https://medium.com/6d-ai/how-is-arcore-better-than-arkit-5223e6b3e79d).
* [Why is ARKit better than the alternatives](https://medium.com/6d-ai/why-is-arkit-better-than-the-alternatives-af8871889d6a).
* [Using ARKit with Metal](http://metalkit.org/2017/07/29/using-arkit-with-metal.html).
* [Augmented Reality With ARKit for iOS](https://digitalleaves.com/blog/2017/08/augmented-reality-arkit/).
* [ARKit and CoreLocation](https://medium.com/journey-of-one-thousand-apps/arkit-and-corelocation-part-one-fc7cb2fa0150).
* [How to build an interactive AR app in 5 mins w/ React Native & Viro AR](https://blog.viromedia.com/how-to-build-an-interactive-ar-app-in-5-mins-w-react-native-viro-ar-e420147e1612).
* [Building an iPhone AR Museum App in iOS 11 with Apple’s ARKit Image Recognition](https://medium.com/codeandco/building-an-iphone-ar-museum-app-in-ios-11-with-apples-arkit-image-recognition-b07febd90a91).
* [Building an AR Game wit ARKit](https://blog.pusher.com/building-ar-game-arkit-spritekit/).
* [Add Snapchat-like AR Lenses to any app w/ Viro AR in React Native](https://blog.viromedia.com/add-snapchat-ar-lenses-to-any-app-w-react-native-viro-ar-9d4053769782).
* [Tutorial: Image Recognition - How to use markers to showcase a product in AR](https://blog.viromedia.com/tutorial-image-recognition-how-to-markers-showcase-product-retail-arkit-arcore-augmented-reality-dc4ce7e7c8f).
* [Image/Marker Recognition for ARCore (Android)](https://blog.viromedia.com/image-marker-recognition-arcore-android-augmented-reality-1855981f5165).
* [ARKit by Example](https://blog.markdaws.net/apple-arkit-by-example-ef1c8578fb59).
* [Medium's Augmented Reality](https://medium.com/tag/augmented-reality).
* [r/ARKitCreators](https://www.reddit.com/r/ARKitCreators/).
* [r/LearnARdev](https://www.reddit.com/r/LearnARdev/).



### Courses


* [Building Your First AR Experience](https://developer.apple.com/documentation/arkit/building_your_first_ar_experience).
* [Google's AR Experiments](https://experiments.withgoogle.com/collection/ar).
* [The Complete iOS 11 ARKit Developer Course](https://www.udemy.com/ios11augmentedrealitycourse).
* [iOS Augmented Reality curs on ArKit](https://www.udemy.com/ios-augmented-reality-the-complete-course-on-arkit/?siteID=Fh5UMknfYAU-KPE8Y4QfnASNEKPRXdbq1Q&LSNPUBID=Fh5UMknfYAU).
* [Augmented Reality Portal using ARKit](https://www.udemy.com/arkit-portal-learn-how-to-create-a-portal-using-arkit/learn/v4/overview).
* [ARKit Unity & Xcode - Build 7 Augmented Reality apps](https://www.udemy.com/arkit-course-ios-11-build-3-awesome-ar-apps/?siteID=Fh5UMknfYAU-nmxSqJMfNu9HQNLs4PkWJA&LSNPUBID=Fh5UMknfYAU).
* [Mastering ARKit for iOS](https://www.udemy.com/mastering-arkit-for-ios-using-swift).
* [Learn ARKit 2 for iOS 12 from Scratch](https://www.udemy.com/learn-arkit-for-ios-from-scratch/?siteID=Fh5UMknfYAU-yVHIgFgDQIzJUKXRiABlOA&LSNPUBID=Fh5UMknfYAU).
* [Udacity's 'Learn ARKit'](https://in.udacity.com/course/learn-arkit--nd114).
* [Made with ARKit](http://www.madewitharkit.com/).
* [A Software Engineer’s Guide to Unity and AR/VR Development](https://blog.betawave.io/a-software-engineers-guide-to-unity-and-ar-vr-development-part-1-c20ce973bf8e).
* [Building AR/VR with Javascript and HTML](https://hackernoon.com/building-ar-vr-with-javascript-and-html-28acd1da0371).
* [iOS Learning Material](https://github.com/jVirus/ios-learning-materials).


### Code Samples

* [SwiftShot: Creating a Game for Augmented Reality](https://developer.apple.com/documentation/arkit/swiftshot_creating_a_game_for_augmented_reality).
* [Awesome ARKit](https://github.com/olucurious/Awesome-ARKit).
* [Creating an Immersive AR Experience with Audio](https://developer.apple.com/documentation/arkit/creating_an_immersive_ar_experience_with_audio).
* [Using Vision in Real Time with ARKit](https://developer.apple.com/documentation/arkit/using_vision_in_real_time_with_arkit).
* [Viro code samples](https://github.com/viromedia/viro).
* [ARKit Sampler](https://github.com/shu223/ARKit-Sampler).

--------

## Virtual Reality

### Devices

#### Devices supporting three degrees of freedom:

* [Google Cardboard](https://vr.google.com/cardboard/).
* [Google Daydream](https://vr.google.com/daydream/).
* [Samsung Gear VR](https://www.oculus.com/gear-vr/).


#### Devices supporting six degrees of freedom:

* [HTC Vive](https://www.vive.com/us/).
* [Oculus Rift](https://www.oculus.com/rift/#oui-csl-rift-games=mages-tale).


### Game Engines

* [Unity](https://unity3d.com/): uses C# as its primary programming language.
* [Unreal](https://www.unrealengine.com/en-US/vr): uses C++ and a node-based language called Blueprints Visual Scripting.

### Development

* [React 260](https://facebook.github.io/react-360/).
* [WebVR](https://webvr.info/): open standard with a JavaScript API that makes it possible to experience VR in your browser.
* [A-frame](https://aframe.io/): framework for building virtual reality experiences with HTML.
* [React VR](https://facebook.github.io/react-360/): library developed by Facebook based on React and React Native.
* [treejs](https://threejs.org/).

### Assets

#### Making 

* [Blender](https://www.blender.org/).
* [Maya](https://www.autodesk.com/products/maya/overview).
* [3ds Max](https://www.autodesk.com/products/3ds-max/overview).

#### Buying 

* [TurboSquid](https://www.turbosquid.com/).
* [Free 3D](https://free3d.com/).
* [CGTrader](https://www.cgtrader.com/).
* [SketchFab](https://sketchfab.com/).

### UI/UX

* [Design guidelines from Google](https://designguidelines.withgoogle.com/cardboard/designing-for-google-cardboard/a-new-dimension.html).
* [UX Guide for VR](https://www.dtelepathy.com/blog/philosophy/ux-guide-designing-virtual-reality-experiences).
* [The UX of VR](https://www.uxofvr.com/).
* [UI / UX design patterns in virtual reality](http://realityshift.io/blog/ui-ux-design-patterns-in-virtual-reality).
* [VR Design best practices](https://medium.com/@LeapMotion/vr-design-best-practices-bb889c2dc70).


### Quintessential VR News & Blogs


* [Upload](https://uploadvr.com/).
* [VR Scout](https://vrscout.com/).
* [Road to VR](https://www.roadtovr.com/).
* [Oculus Blog](https://www.oculus.com/blog/).
* [Vive Blog](https://blog.vive.com/us/).
* [Think Mobiles](https://thinkmobiles.com/blog/).
* [XDA Developers](https://forum.xda-developers.com/mobile-vr).
* [Haptic.al](https://haptic.al/).


### VR Channels

* [Veer TV](https://veer.tv/).
* [NurFACEGAMES](https://www.youtube.com/user/NurFACEGAMES).
* [FusedVR](https://www.youtube.com/channel/UCLO98KHpNx6JwsdnH04l9yQ).
* [Virtual Reality](https://www.youtube.com/playlist?list=PL3VQ6QcS8audF4bt7Gf-cCvNf8aTFcsY4).
* [TED Talks](https://www.ted.com/search?q=virtual+reality).


### VR Courses

* [Udemy Introduction to VR with Unity](https://www.udemy.com/introduction-to-vr-with-unity/).
* [Udemy Google's VR Course](https://www.udacity.com/course/introduction-to-virtual-reality--ud1012).
* [Udemy Google's VR Software Development](https://www.udacity.com/course/vr-software-development--ud1014).
* [VR Dev School](https://learn.vrdev.school/).
* [Coursera's VR Specialization](https://www.coursera.org/specializations/virtual-reality).
* [Unity 3D tutorials](https://unity3d.com/learn/tutorials).
* [Cat Like Coding tutorial](https://catlikecoding.com/unity/tutorials/).
* [Google's Unreal Tutorial](https://developers.google.com/vr/develop/unreal/get-started).
* [Google's VR SDK for iOS](https://developers.google.com/vr/develop/ios/get-started).
* [Google's VR SDK for Android](https://developers.google.com/vr/develop/android/get-started).
* [Creating Virtual Reality (VR) Apps](https://www.edx.org/course/creating-virtual-reality-vr-apps-uc-san-diegox-cse190x).


### VR Podcasts

* [VR Scout](https://vrscout.com/podcast/).
* [Enter VR](http://entervr.net/category/podcast/).
* [Road to VR](https://www.roadtovr.com/vr-podcasts/).
* [Voices of VR](http://voicesofvr.com/).
* [Rev VR Studios](http://www.revvrstudios.com/).
* [MatthewHallberg](https://www.youtube.com/channel/UClm2DY6pj3ygKoKhEVr7KFw).


### VR Forums

* [VRTalk](http://www.vrtalk.com/forum/).
* [VR Heads](https://forums.vrheads.com/).
* [Quora](https://www.quora.com/topic/Virtual-Reality-VR).
* [Oculus VR](https://forums.oculusvr.com/community).
* [Unity](https://forum.unity.com/forums/ar-vr-xr-discussion.80/).
* [/r/oculus](https://www.reddit.com/r/oculus).
* [/r/augmentedreality](https://www.reddit.com/r/augmentedreality).
* [/r/vitrualreality](https://www.reddit.com/r/virtualreality/).
* [/r/Singularitarianism](https://www.reddit.com).
* [/r/HTC_Vive](https://www.reddit.com/r/HTC_Vive).
* [/r/learnVRdev](https://www.reddit.com/r/learnVRdev/).

### Some Terminology

* **Field of view**: measured in degrees, is the extent of the observable world that is seen at any given moment (humans have a FOV of around 180°, but most HMDs offer between 50 and 110°).

* **Latency**: In VR, a 20 millisecond latency is considered low and acceptable for a comfortable experience.

* **Haptics**: recreate the sense of touch by applying forces, vibrations, or motions to the user, through feedback devices (example, vibrating game controllers).

* **Stitching**: the process of combining multiple video sources with overlapping fields of view to produce a fully immersive 360°. 

* **Visual Inertial Odometry**: ARKit analyzes the phone camera and motion data in order to keep track of the world around i
ARSession object that manages the motion tracking and image processing.



---------

## License


<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).
