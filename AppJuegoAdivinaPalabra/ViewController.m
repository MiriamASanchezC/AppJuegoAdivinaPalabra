
//
//  ViewController.m
//  AppJuegoAdivinaPalabra
//
//  Created by Miriam Sanchez on 19/03/25.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *animales;
@property (nonatomic, strong) NSString *animalActual;
@property (nonatomic, strong) NSString *animalActualemoji;
@property (nonatomic, strong) NSArray *pistasActuales;
@property (nonatomic) NSInteger puntuacion;
@property (nonatomic, strong) NSString *palabraOculta;
@property (nonatomic) NSInteger indicePista;
@property (nonatomic, strong) NSMutableArray *animalesDisponibles;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondoselva"]];
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];

    self.animales = @[
        @{@"word": @"elefante", @"emoji": @"🐘", @"hints": @[@"Es el animal terrestre más grande", @"Tiene una trompa larga", @"Tiene grandes orejas y vive en África y Asia"]},
        @{@"word": @"jirafa", @"emoji": @"🦒", @"hints": @[@"Tiene un cuello muy largo", @"Es el animal terrestre más alto", @"Vive en África y come hojas de árboles altos"]},
        @{@"word": @"canguro", @"emoji": @"🦘", @"hints": @[@"Es originario de Australia", @"Salta con sus fuertes patas traseras", @"Lleva a su cría en una bolsa"]},
        @{@"word": @"panda", @"emoji": @"🐼", @"hints": @[@"Es blanco y negro", @"Come bambú", @"Es nativo de China"]},
        @{@"word": @"tigre", @"emoji": @"🐅", @"hints": @[@"Es un gran felino", @"Tiene pelaje naranja con rayas negras", @"Es nativo de Asia"]},
        @{@"word": @"ballena", @"emoji": @"🐋", @"hints": @[@"Es el animal más grande de la Tierra", @"Vive en el océano", @"Es un mamífero y respira aire"]},
        @{@"word": @"pingüino", @"emoji": @"🐧", @"hints": @[@"Es un ave que no puede volar", @"Vive en regiones frías", @"Es conocido por su apariencia de esmoquin"]},
        @{@"word": @"delfín", @"emoji": @"🐬", @"hints": @[@"Es un mamífero marino altamente inteligente", @"Se comunica con clics y silbidos", @"Es conocido por su naturaleza juguetona"]},
        @{@"word": @"león", @"emoji": @"🦁", @"hints": @[@"Es conocido como el rey de la selva", @"Tiene melena", @"Es un gran felino nativo de África"]},
        @{@"word": @"cebra", @"emoji": @"🦓", @"hints": @[@"Tiene rayas blancas y negras", @"Se parece a un caballo", @"Vive en África y es herbívora"]}
    ];

        self.animalesDisponibles = [self.animales mutableCopy];
        self.puntuacion = 0;
        [self iniciarNuevoJuego];
}

- (void)iniciarNuevoJuego {
    // Si ya se usaron todos, reiniciar la lista
        if (self.animalesDisponibles.count == 0) {
            self.animalesDisponibles = [self.animales mutableCopy];
            [self mostrarAlertaConTitulo:@"¡Todos los animales han sido adivinados!" mensaje:@"Comenzamos una nueva ronda."];
        }

        // Elegir un animal aleatorio de los disponibles
        NSInteger indiceAleatorio = arc4random_uniform((uint32_t)self.animalesDisponibles.count);
        NSDictionary *animalSeleccionado = self.animalesDisponibles[indiceAleatorio];

        self.animalActual = animalSeleccionado[@"word"];
        self.pistasActuales = animalSeleccionado[@"hints"];
        self.animalActualemoji = animalSeleccionado[@"emoji"];
        self.indicePista = 0;

        // Ocultar la palabra
       // self.palabraOculta = [@"" stringByPaddingToLength:self.animalActual.length withString:@"_" startingAtIndex:0];

        // Actualizar la UI
       // self.wordLabel.text = self.palabraOculta;
        self.hintLabel.text = [NSString stringWithFormat:@"Pista: %@", self.pistasActuales[self.indicePista]];
        self.scoreLabel.text = [NSString stringWithFormat:@"Puntuación: %ld", (long)self.puntuacion];

        // Eliminar el animal usado de la lista disponible
        [self.animalesDisponibles removeObjectAtIndex:indiceAleatorio];
}


- (IBAction)NewGame:(id)sender {
    self.puntuacion = 0;
    [self iniciarNuevoJuego];
    [self mostrarAlertaConTitulo:@"Nuevo Juego" mensaje:@"Comenzarás un nuevo juego"];
   
}

- (IBAction)comprobarPalabra:(id)sender {
    NSString *entradaUsuario = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].lowercaseString;
       NSString *entradaNormalizada = [self quitarAcentosDe:entradaUsuario];
       NSString *respuestaCorrecta = [self quitarAcentosDe:self.animalActual.lowercaseString];

       if ([entradaNormalizada isEqualToString:respuestaCorrecta]) {
           self.puntuacion += 5;
           self.scoreLabel.text = [NSString stringWithFormat:@"Puntuación: %ld", (long)self.puntuacion];
           [self mostrarAlertaConTitulo:@"¡Correcto! 🎉" mensaje:[NSString stringWithFormat:@"Era %@", self.animalActualemoji]];
           self.emojiLabel.font = [UIFont systemFontOfSize:80.0];
           self.emojiLabel.text = self.animalActualemoji;

           

           [self iniciarNuevoJuego];
           self.textField.text = @""; // Limpia el campo de texto
       } else {
           if (self.indicePista < self.pistasActuales.count - 1) {
               [self mostrarAlertaConTitulo:@"Incorrecto" mensaje:@"¡Intenta otra vez!"];
               self.textField.text = @"";
               self.indicePista++;
               self.hintLabel.text = [NSString stringWithFormat:@"Pista: %@", self.pistasActuales[self.indicePista]];
           } else {
               [self mostrarAlertaConTitulo:@"Ya no hay pistas" mensaje:@"Juega de nuevo"];
               self.textField.text = @"";
               [self iniciarNuevoJuego];
           }
       }
}

- (void)mostrarAlertaConTitulo:(NSString *)titulo mensaje:(NSString *)mensaje {
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:titulo
                                                                   message:mensaje
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *accionOK = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    [alerta addAction:accionOK];
    [self presentViewController:alerta animated:YES completion:nil];
}

- (NSString *)quitarAcentosDe:(NSString *)texto {
    NSMutableString *mutable = [texto mutableCopy];
    CFStringTransform((CFMutableStringRef)mutable, NULL, kCFStringTransformStripCombiningMarks, NO);
    return mutable;
}

@end
