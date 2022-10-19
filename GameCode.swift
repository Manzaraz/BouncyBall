import Foundation

/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

let ball = OvalShape(width: 40, height: 40)
let barrierWidth = 300.0
let barrierHeight = 25.0

let barrierPoints = [
    Point(x: 0, y: 0),
    Point(x: 0, y: barrierHeight),
    Point(x: barrierWidth, y: barrierHeight),
    Point(x: barrierWidth, y: 0)
]

let barrier = PolygonShape(points: barrierPoints)

// Agregar un embudo
let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0)
]
let funnel = PolygonShape(points: funnelPoints)

// Agregar un objetivo
let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y: 10)
]
let target = PolygonShape(points: targetPoints)


fileprivate func setupBall() {
    ball.position = Point(x: 250, y: 400)
    scene.add(ball) // agrega el ball a la escena
    ball.hasPhysics = true // La propiedad hasPhysics participa en la simulación de la física del motor del juego
    ball.fillColor = .blue // Personalizo el color de nuestra pelota con la propiedad fillColor
    ball.onCollision = ballCollided(with:)
    
    ball.isDraggable = false // para e vitar que el usuario pueda arrastrar la pelota
    
    scene.trackShape(ball)
    ball.onExitedScene = ballExitedScene
    ball.onTapped = resetGame
}

fileprivate func setupBarrier() {
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    scene.add(barrier)
    barrier.isImmobile = true
    barrier.fillColor = .brown
}

fileprivate func setupFunnel() {
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    funnel.onTapped = dropBall // La propiedad onTapped es una función en donde la funcion dropBall dejará caer la pelota
    funnel.fillColor = .lightGray
    
    funnel.isDraggable = false // con esto e vito que el usuario pueda arrastar el embudo
}

func setupTarget() {
    target.position = Point(x: 200, y: 200)
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.fillColor = .yellow
    
    scene.add(target)
    target.name = "target"
}

// Maneja las colisiones entre la bola y los objetos
func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" {return}
    otherShape.fillColor = .green
}


func setup() {
    scene.backgroundColor = .darkGray
    setupBall()
    
    /// Agregar un obstáculo a la escena.
    setupBarrier()

    // Agrega un embudo a la escena
    setupFunnel()
    
    // Agrego un objetivo a la escena
    setupTarget()
    
    resetGame() // para que el juego se inicie sin la pelota en la pantalla 
}

// Deja caer la pelota al moverla a la posición del embudo.
func dropBall() {
    ball.position = funnel.position
    
    ball.stopAllMotion() // para detener la pelota que se escapa
    barrier.isDraggable = false
}

func ballExitedScene() {
    barrier.isDraggable = true
}


// Reestablese el juego al mover la pelota por debajo de la escena
// esto desbloqueará los obstáculos
func resetGame() {
    ball.position = Point(x: 0, y: -80)
}
