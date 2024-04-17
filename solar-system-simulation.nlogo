breed [planets planet]
breed [stars star]

globals [
  orbit-speed     ; Velocidad orbital de los planetas
]

planets-own [
  semimajor-axis  ; Eje semi-mayor de la órbita de los planetas
  initial-x       ; Posición inicial en x
  initial-y       ; Posición inicial en y
]

patches-own [
  painted?  ; Variable para indicar si el parche ha sido pintado
  paint-thickness  ; Grosor de la pintura en el parche
]

to setup
  clear-all
  set orbit-speed 0 ; Velocidad orbital de los planetas
  
  create-planets 1 [
    set breed stars   ; Creamos solo una turtle para representar el sol y le establecemos la raza 'planets'
    set shape "circle"
    set color yellow
    set size 3
    setxy 0 0  ; Coloca el sol en el centro
  ]
  
  create-planets 9 [
    set breed planets
    set shape "circle"
    set color one-of [blue green red orange brown yellow cyan magenta]  ; Colores para los planetas
    set size 1
    set initial-x random 141 - 70  ; Limita el rango de valores entre -60 y 60
    set initial-y random 141 - 70  ; Limita el rango de valores entre -60 y 60
    set semimajor-axis sqrt (initial-x ^ 2 + initial-y ^ 2)  ; Calculamos el eje semi-mayor como la distancia al origen
    setxy initial-x initial-y
    set heading random 360
  ]
  
  reset-ticks
end

to go
  ask planets [
    let angular-speed 0.0001  ; Velocidad angular de movimiento del planeta (ajusta según sea necesario)
    let planet-angle (ticks * angular-speed) + random-float 360  ; Calcula el ángulo actual del planeta con una variación aleatoria
    let x semimajor-axis * cos planet-angle  ; Calcula la nueva posición x del planeta
    let y semimajor-axis * sin planet-angle  ; Calcula la nueva posición y del planeta
    let new-x ([xcor] of one-of turtles with [breed = stars] + x)  ; Nueva posición x del planeta
    let new-y ([ycor] of one-of turtles with [breed = stars] + y)  ; Nueva posición y del planeta
    move-to patch new-x new-y  ; Mueve el planeta a su nueva posición
    
    ; Pintar el parche donde se encuentra el planeta si no ha sido pintado
    let current-patch patch-here
    if painted? = 0 [
      ask current-patch [
        set pcolor [color] of myself  ; Pinta el parche con el color del planeta
        set painted? 1  ; Marca el parche como pintado
        set paint-thickness 0.5  ; Establece el grosor de la pintura en el parche
        set pcolor 0.5
      ]
    ] 
    
  ]
  tick
end
