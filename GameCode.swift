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


fileprivate func setupBall() {
    ball.position = Point(x: 250, y: 400)
    scene.add(ball) // agrega el ball a la escena
    ball.hasPhysics = true // La propiedad hasPhysics participa en la simulación de la física del motor del juego
    ball.fillColor = .blue // Personalizo el color de nuestra pelota con la propiedad fillColor
}

fileprivate func setupBarrier() {
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    scene.add(barrier)
    barrier.isImmobile = true
    barrier.fillColor = .brown
}

fileprivate func setupFunnel() {
    // Agrega un embudo a la escena
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    funnel.onTapped = dropBall // La propiedad onTapped es una función en donde la funcion dropBall dejará caer la pelota
    funnel.fillColor = .darkGray
}

func setup() {
    setupBall()
    
    /// Agregar un obstáculo a la escena.
    setupBarrier()

    // Agrega un embudo a la escena
    setupFunnel()
}

// Deja caer la pelota al moverla a la posición del embudo.
func dropBall() {
    ball.position = funnel.position
}
