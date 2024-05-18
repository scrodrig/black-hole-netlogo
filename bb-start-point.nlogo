breed [planets planet]
breed [stars star]

globals [
  orbit-speed     ; Velocidad orbital de los planetas
  angular-speed   ; Velocidad angular de movimiento del planeta
  previous-sun-mass ; Masa anterior del sol
]

planets-own [
  semimajor-axis  ; Eje semi-mayor de la órbita de los planetas
  initial-x       ; Posición inicial en x
  initial-y       ; Posición inicial en y
  mass            ; Masa del planeta
]

patches-own [
  painted?        ; Variable para indicar si el parche ha sido pintado
  paint-thickness ; Grosor de la pintura en el parche
]

stars-own [
  mass            ; Masa de la estrella
]

to setup
  clear-all
  set orbit-speed 0 ; Velocidad orbital de los planetas
  set angular-speed 0.001 ; Velocidad angular de movimiento del planeta (ajustar según sea necesario)
  set sun-mass 100
  set previous-sun-mass sun-mass

  create-planets 1 [
    set breed stars   ; Creamos solo una tortuga para representar el sol y le establecemos la raza 'planets'
    set shape "circle"
    set color yellow
    set size 3
    set mass sun-mass      ; Establecemos la masa del sol
    setxy 0 0  ; Coloca el sol en el centro
  ]

  create-planets 9 [
    set breed planets
    set shape "circle"
    set color one-of [blue green red orange brown yellow cyan magenta]  ; Colores para los planetas
    set size 1
    set initial-x random 141 - 70  ; Limita el rango de valores entre -70 y 70
    set initial-y random 141 - 70  ; Limita el rango de valores entre -70 y 70
    set semimajor-axis sqrt (initial-x ^ 2 + initial-y ^ 2)  ; Calculamos el eje semi-mayor como la distancia al origen
    set mass (random 200)  ; Establecemos la masa del planeta como un número aleatorio entre 1 y 100
    setxy initial-x initial-y
    set heading random 360
;    set label mass
  ]

  reset-ticks
end

to detect-collisions
  ask planets [
    let min-distance min [distance myself] of stars
    if min-distance < ([size] of one-of stars / 2) [ ; Comprobar si hay colisión con alguna estrella (considerando el radio)
      ask one-of stars [ ; Agregar la masa del planeta al sol antes de que el planeta muera
        set mass mass + [mass] of myself
      ]
      set color black  ; Cambiar el color del planeta a negro
      die
    ]
  ]
end




to go
  detect-collisions  ; Detect collisions before planets move

  ask planets [
    let planet-angle heading

    ; Calculate distance between planet and sun
    let distance-to-star distance one-of stars

    ; Calculate change in sun's mass
    let delta-mass (sun-mass - previous-sun-mass)

    ; Calculate orbit deformation based on change in sun's mass
    let orbit-deformation ( mass - [mass] of one-of stars ) / 100
;    set label mass

    ; Calculate new semi-major axis of orbit
    let new-semimajor-axis semimajor-axis + orbit-deformation

    let x new-semimajor-axis * cos planet-angle  ; Calculate new x position of the planet
    let y new-semimajor-axis * sin planet-angle  ; Calculate new y position of the planet

    ; Move the planet to its new position
    setxy ([xcor] of one-of turtles with [breed = stars] + x) ([ycor] of one-of turtles with [breed = stars] + y)

    ; Paint the patch where the planet is located if not painted yet
    let current-patch patch-here
    if painted? = 0 [
      ask current-patch [
        set pcolor [color] of myself  ; Paint the patch with the planet's color
        set painted? 1  ; Mark the patch as painted
        set pcolor 0.2
      ]
    ]

    ; Increase size of stars if sun's mass increases
    if sun-mass > previous-sun-mass [
      ask stars [
        set size [size] of one-of stars + (0.1)
      ]
    ]

    ; Update previous sun mass
    set previous-sun-mass sun-mass

    ; Adjust turtle's angle to simulate slower movement
    set heading (heading + angular-speed) mod 360
  ]

  ; Change sun's color based on its mass
  if sun-mass > 2000 and sun-mass <= 3500 [
    ask one-of stars [
      set color orange
    ]
  ]

  if sun-mass > 3500 and sun-mass <= 5000 [
    ask one-of stars [
      set color red
    ]
  ]

  if sun-mass > 6500 [
    ask one-of stars [
      set color black
      set size 10  ; Ajusta el tamaño para simular el borde
      set pen-mode "down" ; Asegura que el borde esté visible
      set pen-size 5  ; Ajusta el grosor del borde
;      set pen-color orange  ; Establece el color del borde en naranja
    ]
  ]

  ; Update sun's mass in all planets
  ask stars [
    set mass sun-mass
  ]
  tick
end


