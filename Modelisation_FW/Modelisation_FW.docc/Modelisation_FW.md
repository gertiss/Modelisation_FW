#  Modelisation doc

## Structure

La modélisation d'un domaine se fait à l'aide de types Swift par valeur.

Un "objet du modèle" peut être simple ou composé :

- Un atome Swift (String, Int, Double, Bool)
- Une enum sans valeurs associées
- Un Array d'objets
- Un Set d'objets
- Une struct dont les variables stockées sont des objets
- Une enum dont les cas avec valeur associée ont des valeurs objets


## Littéral

Certains types objets peuvent admettre une représentation en "littéral". Pour cela ils doivent être déclarés conformes à `CodableEnLitteral`. Un littéral est un objet censé être communicable de manière publique, alors que les types objets sont a priori privés. L'objet connaît son littéral. Le littéral est public mais l'objet est privé.

    public typealias UnLitteral = AvecCodeSwift & CodableEnJson 

    public protocol AvecCodeSwift {
        var codeSwift: String { get }
    }

    public protocol CodableEnJson: Codable {
        var jsonResult: Result<String, String> { get }
        static func avecJsonResult(_ code: String) -> Result<Self, String>
    }

    public protocol CodableEnLitteral {
        associatedtype Litteral: UnLitteral
        var litteral: Litteral { get }
        init(litteral: Litteral)
    }

Convention de nommage en Swift :  si un type X est conforme à `CodableEnLitteral` alors son type littéral associé `X.Litteral` doit s'appeler `X_`. Ce n'est qu'une convention humaine, elle ne peut pas être vérifiée ni statiquement par le compilateur ni dynamiquement par programme. Elle est importante pour la lisibilité et la cohérence.

Un "littéral" peut être simple ou composé :

- Un atome Swift (String, Int, Double, Bool)
- Une enum sans valeurs associées
- Un Array de littéraux
- Un Set de littéraux
- Une struct dont les variables stockées sont des littéraux
- Une enum dont les cas avec valeur associée ont des valeurs littérales

Un littéral peut être plus "plat" que l'objet qu'il représente, grâce à la possibilité pour un objet d'être conforme au protocole `CodableParNom` :

    public protocol CodableParNom:  Hashable, CodableEnLitteral, Codable, AvecLangage {
        var nom: String { get }
        init(nom: String)
    }

Même si le type X de l'objet est composé, lorsqu'il est `CodableParNom` son type littéral associé `X_` est String, ce qui fait que la structure de X est "aplatie" en une String de manière opaque. L'utilisateur de `X_` ne voit qu'une String.

Dans les autres cas, la structure du littéral `X_` est quasiment isomorphe à celle de l'objet `X`.

Mais si c'est isomorphe, pourquoi déclarer deux types ? Cela semble redondant et inutile ! 

Les différences importantes sont les suivantes :

- le type objet `X` est privé, alors que le type littéral `X_` est public. Cela permet de choisir ce qu'on décide de rendre visible ou pas.
- le type littéral `X_` est plus adapté à la mise au point d'une interface, au debug, à l'affichage, à la lisibilité, à la saisie manuelle, à l'import-export sur fichier.
- le type littéral `X_` est plus simple, il a moins de méthodes, seulement celles qui peuvent être utiles pour une interface.
- le type littéral `X_` a moins de contraintes internes car ce n'est qu'une entité de nature syntaxique, sans sémantique intrinsèque.
- le type objet `X` est plus adapté aux vérifications sémantiques et aux traitements algorithmiques complexes. Cela risque de le rendre plus complexe, mais cette complexité n'est pas répercutée sur le littéral.


## Exemples

### CodableParNom. Litteral String

    struct Cellule {
        let indexLigne: Int
        let indexColonne: Int
    }

	extension Cellule: CodableParNom {
    
	    public var nom: String {
	        return "\(ligne.nom)\(colonne.nom)"
	    }
	
	    public init(nom: String) {
	        let ligneColonne = nom.map { String($0) }
	        let ligne = ligneColonne[0]
	        let colonne = ligneColonne[1]
	        let indexLigne = Ligne.noms.firstIndex(of: ligne)!
	        let indexColonne = Colonne.noms.firstIndex(of: colonne)!
	        self = Cellule(indexLigne, indexColonne)
    	}
    }
    
`init(nom:)` effectue une analyse syntaxique.
`ligne` est de type Ligne, qui est CodableParNom.
`colonne` est de type Colonne, qui est CodableParNom.

Pour faire profiter l'interface de certaines fonctions d'accès permettant de retrouver les attributs de l'objet, il faut des fonctions globales publiques à partir du nom :

    public func indexLigne(cellule nom: String) -> Int {
        Cellule(nom: nom).indexLigne
    }

    public func indexColonne(cellule nom: String) -> Int {
        Cellule(nom: nom).indexColonne
    }


### Litteral composé


	struct SingletonEliminateur 
		let singleton: Presence
	}
	
    struct SingletonEliminateur_: UnLitteral, Equatable {
        let singleton: Presence_ 
        var codeSwift: String {
        	"SingletonEliminateur_(singleton: \(singleton.codeSwift))"
    	}
	}
	
L'attribut singleton du littéral a une valeur littérale Presence_

	extension SingletonEliminateur: CodableEnLitteral {
		typealias Litteral = SingletonEliminateur_
    
    	var litteral: SingletonEliminateur_ {
        	SingletonEliminateur_(singleton: singleton.litteral)
    	}
    
    	init(litteral: SingletonEliminateur_) {
    		self.singleton = Presence(litteral: litteral.singleton)
    	}
	}


On peut étendre le littéral pour lui faire profiter de certaines fonctions d'accès à des données liées à l'objet. Les valeurs rendues doivent être des littéraux.

    extension SingletonEliminateur_ {
        var valeur: Int {
            Presence(litteral: singleton).valeurs.uniqueElement
        }
    }
    
Dans la ligne I, il ne reste que deux cellules Id Ie, donc paire IdIe_49 en jaune.

Donc cela élimine 4 et 9 dans toutes les autres cases du carré Pn, en orange, en particulier dans la colonne f, en Gf et Hf. 

Puis on raisonne pour la valeur 4 dans la colonne f. Gf et Hf sont éliminées par le raisonnement précédent, Bf en rouge est éliminée à cause de Bb_4, Ff en rouge est éliminée à cause de Fa. Il ne reste plus que Df en vert.
