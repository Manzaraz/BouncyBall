import Foundation

/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

let circle = OvalShape(width: 150, height: 150)
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

func setup() {
//    /// Agregar un obstáculo a la escena.
//    barrier.position = Point(x: 200, y: 150)
    /// Define la asignación de la posición de nuestra "bola" dentro de la pantalla a través de las coordenadas x e y
    circle.position = Point(x: 250, y: 400)
    scene.add(circle) // agrega el circle a la escena
    
    /// La propiedad hasPhysics participa en la simulación de la física del motor del juego
    circle.hasPhysics = true
    
    /// Agregar un obstáculo a la escena.
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    scene.add(barrier)
    barrier.isImmobile = true
    
    // Agrega un embudo a la escena
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)

    // La propiedad onTapped es una función en donde la funcion dropBall dejará caer la pelota 
    funnel.onTapped = dropBall
}

// Deja caer la pelota al moverla a la posición del embudo.
func dropBall() {
    circle.position = funnel.position
}
