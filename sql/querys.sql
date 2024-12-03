INSERT INTO [dbo].[Infraccion] (descripcion)
VALUES 
    ('Mal estacionado'),
    ('Puesto prohibido/reservado'),
    ('Estacionamiento mal indicado');
GO

INSERT INTO [dbo].[Marca] (nombre_marca) VALUES
    ('Ford'), ('Fiat'), ('Peugeot'), ('Citroën'), ('Chevrolet'), 
    ('Nissan'), ('Renault'), ('Volkswagen'), ('Toyota'), 
    ('Honda'), ('Hyundai'), ('Kia'), ('Mercedes Benz'), 
    ('BMW'), ('Audi'), ('Changan'), ('JAC Motors'), ('BYD');
GO

INSERT INTO [dbo].[Modelo] (nombre_modelo, id_marca) VALUES
    ('Ford Fiesta', 1), ('Ford Focus', 1), ('Ford EcoSport', 1), 
    ('Ford Ranger', 1), ('Ford Kuga', 1), ('Ford Mustang', 1),
    ('Fiat Uno', 2), ('Fiat Palio', 2), ('Fiat Argo', 2), 
    ('Fiat Cronos', 2), ('Fiat Toro', 2),
    ('Peugeot 208', 3), ('Peugeot 308', 3), ('Peugeot 2008', 3), 
    ('Peugeot 3008', 3), ('Peugeot 5008', 3),
    ('Citroën C3', 4), ('Citroën C4 Lounge', 4), ('Citroën C5 Aircross', 4), 
    ('Citroën Berlingo', 4),
    ('Chevrolet Onix', 5), ('Chevrolet Tracker', 5), ('Chevrolet Spin', 5), 
    ('Chevrolet S10', 5), ('Chevrolet Tracker', 5),
    ('Nissan Versa', 6), ('Nissan Frontier', 6), ('Nissan Kicks', 6), 
    ('Nissan Qashqai', 6),
    ('Renault Kwid', 7), ('Renault Sandero', 7), ('Renault Logan', 7), 
    ('Renault Duster', 7), ('Renault Oroch', 7),
    ('Volkswagen Gol', 8), ('Volkswagen Polo', 8), ('Volkswagen T-Cross', 8), 
    ('Volkswagen Tiguan', 8), ('Volkswagen Amarok', 8),
    ('Toyota Corolla', 9), ('Toyota Hilux', 9), ('Toyota Yaris', 9), 
    ('Toyota RAV4', 9), ('Toyota Land Cruiser', 9),
    ('Honda HR-V', 10), ('Honda Civic', 10), ('Honda City', 10), 
    ('Honda CR-V', 10),
    ('Hyundai Creta', 11), ('Hyundai Tucson', 11), ('Hyundai Elantra', 11), 
    ('Hyundai Santa Fe', 11),
    ('Kia Seltos', 12), ('Kia Sportage', 12), ('Kia Rio', 12), 
    ('Kia Cerato', 12),
    ('Mercedes-Benz Clase A', 13), ('Mercedes-Benz Clase C', 13), 
    ('Mercedes-Benz GLA', 13), ('Mercedes-Benz GLC', 13),
    ('BMW Serie 1', 14), ('BMW Serie 3', 14), ('BMW X1', 14), 
    ('BMW X3', 14),
    ('Audi A3', 15), ('Audi A4', 15), ('Audi Q3', 15), 
    ('Audi Q5', 15),
    ('Changan CS35', 16), ('Changan Alsvin', 16),
    ('JAC S2', 17), ('JAC S3', 17), ('JAC T6', 17),
    ('BYD F0', 18), ('BYD Song', 18);
GO


INSERT INTO [dbo].[Estacionamiento] (ocupado, ubicacionX, ubicacionY) 
VALUES 
(0, -34.597392, -58.46271), -- 1,
(0, -34.567631, -58.413925), -- 2,
(0, -34.561978, -58.490651), -- 3,
(0, -34.55063, -58.40295), -- 4,
(0, -34.556864, -58.388858), -- 5,
(0, -34.561215, -58.496933), -- 6,
(0, -34.610982, -58.468314), -- 7,
(0, -34.553972, -58.374598), -- 8,
(0, -34.574153, -58.479341), -- 9,
(0, -34.611351, -58.398053), -- 10,
(0, -34.605318, -58.525622), -- 11,
(0, -34.634812, -58.520946), -- 12,
(0, -34.555942, -58.411451), -- 13,
(0, -34.578104, -58.404385), -- 14,
(0, -34.61356, -58.414812), -- 15,
(0, -34.552133, -58.479509), -- 16,
(0, -34.589247, -58.376578), -- 17,
(0, -34.594279, -58.398042), -- 18,
(0, -34.631944, -58.437191), -- 19,
(0, -34.574288, -58.511724), -- 20,
(0, -34.551002, -58.415103), -- 21,
(0, -34.580995, -58.480014), -- 22,
(0, -34.5872, -58.527533), -- 23,
(0, -34.553804, -58.379633), -- 24,
(0, -34.56658, -58.463313), -- 25,
(0, -34.629655, -58.384151), -- 26,
(0, -34.628572, -58.447995), -- 27,
(0, -34.556392, -58.370029), -- 28,
(0, -34.587416, -58.424622), -- 29,
(0, -34.569749, -58.401088), -- 30,
(0, -34.578135, -58.442877), -- 31,
(0, -34.59063, -58.446532), -- 32,
(0, -34.586179, -58.44252), -- 33,
(0, -34.560113, -58.385628), -- 34,
(0, -34.586151, -58.453975), -- 35,
(0, -34.583529, -58.492674), -- 36,
(0, -34.595151, -58.464853), -- 37,
(0, -34.593692, -58.390735), -- 38,
(0, -34.573756, -58.403957), -- 39,
(0, -34.557839, -58.503177), -- 40,
(0, -34.614039, -58.478392), -- 41,
(0, -34.595272, -58.447381), -- 42,
(0, -34.586852, -58.465835), -- 43,
(0, -34.578137, -58.512511), -- 44,
(0, -34.60233, -58.488525), -- 45,
(0, -34.574956, -58.414514), -- 46,
(0, -34.58245, -58.529797), -- 47,
(0, -34.564354, -58.37141), -- 48,
(0, -34.628566, -58.37905), -- 49,
(0, -34.610654, -58.37684), -- 50,
(0, -34.587514, -58.522738), -- 51,
(0, -34.584786, -58.493325), -- 52,
(0, -34.57945, -58.493925), -- 53,
(0, -34.613547, -58.439743), -- 54,
(0, -34.552459, -58.51891), -- 55,
(0, -34.58952, -58.447378), -- 56,
(0, -34.588144, -58.394496), -- 57,
(0, -34.586651, -58.491592), -- 58,
(0, -34.553559, -58.406045), -- 59,
(0, -34.606427, -58.490783), -- 60,
(0, -34.608674, -58.422868), -- 61,
(0, -34.577556, -58.441905), -- 62,
(0, -34.596739, -58.463754), -- 63,
(0, -34.586383, -58.474143), -- 64,
(0, -34.595392, -58.423397), -- 65,
(0, -34.599522, -58.38441), -- 66,
(0, -34.634752, -58.413772), -- 67,
(0, -34.593839, -58.392273), -- 68,
(0, -34.560093, -58.389581), -- 69,
(0, -34.575651, -58.429067), -- 70,
(0, -34.574412, -58.401123), -- 71,
(0, -34.585387, -58.523749), -- 72,
(0, -34.579497, -58.504611), -- 73,
(0, -34.578025, -58.460686), -- 74,
(0, -34.620054, -58.380663), -- 75,
(0, -34.573349, -58.371804), -- 76,
(0, -34.580055, -58.423012), -- 77,
(0, -34.559346, -58.412948), -- 78,
(0, -34.561716, -58.370726), -- 79,
(0, -34.559673, -58.520737), -- 80,
(0, -34.564766, -58.445312), -- 81,
(0, -34.553104, -58.480187), -- 82,
(0, -34.629868, -58.458919), -- 83,
(0, -34.588259, -58.404581), -- 84,
(0, -34.62209, -58.47081), -- 85,
(0, -34.619572, -58.464343), -- 86,
(0, -34.577848, -58.465146), -- 87,
(0, -34.590411, -58.379613), -- 88,
(0, -34.625022, -58.420943), -- 89,
(0, -34.622433, -58.502861), -- 90,
(0, -34.634397, -58.450738), -- 91,
(0, -34.611769, -58.400465), -- 92,
(0, -34.586005, -58.479748), -- 93,
(0, -34.627148, -58.45135), -- 94,
(0, -34.617691, -58.41124), -- 95,
(0, -34.608644, -58.464867), -- 96,
(0, -34.618563, -58.421446), -- 97,
(0, -34.579096, -58.466173), -- 98,
(0, -34.613148, -58.373702), -- 99,
(0, -34.616332, -58.485826), -- 100,
(0, -34.63464, -58.529068), -- 101,
(0, -34.568227, -58.4965), -- 102,
(0, -34.595754, -58.375875), -- 103,
(0, -34.612412, -58.462632), -- 104,
(0, -34.57273, -58.417828), -- 105,
(0, -34.622964, -58.383511), -- 106,
(0, -34.598393, -58.418705), -- 107,
(0, -34.574037, -58.400876), -- 108,
(0, -34.566708, -58.428976), -- 109,
(0, -34.596222, -58.463721), -- 110,
(0, -34.610332, -58.458631), -- 111,
(0, -34.633189, -58.449828), -- 112,
(0, -34.554372, -58.474142), -- 113,
(0, -34.61898, -58.514088), -- 114,
(0, -34.573541, -58.445117), -- 115,
(0, -34.584357, -58.424749), -- 116,
(0, -34.557162, -58.456535), -- 117,
(0, -34.597411, -58.517682), -- 118,
(0, -34.620661, -58.50502), -- 119,
(0, -34.625774, -58.477285), -- 120,
(0, -34.579912, -58.437733), -- 121,
(0, -34.591959, -58.46248), -- 122,
(0, -34.590685, -58.488259), -- 123,
(0, -34.578133, -58.385905), -- 124,
(0, -34.609928, -58.514902), -- 125,
(0, -34.570862, -58.509452), -- 126,
(0, -34.574371, -58.396662), -- 127,
(0, -34.56694, -58.521248), -- 128,
(0, -34.572122, -58.447753), -- 129,
(0, -34.565009, -58.459935), -- 130,
(0, -34.553544, -58.435797), -- 131,
(0, -34.624159, -58.501368), -- 132,
(0, -34.634732, -58.43575), -- 133,
(0, -34.61768, -58.436315), -- 134,
(0, -34.593806, -58.458673), -- 135,
(0, -34.618014, -58.41578), -- 136,
(0, -34.608968, -58.527767), -- 137,
(0, -34.605782, -58.52202), -- 138,
(0, -34.607595, -58.519205), -- 139,
(0, -34.605619, -58.453716), -- 140,
(0, -34.60084, -58.514849), -- 141,
(0, -34.586429, -58.508919), -- 142,
(0, -34.586267, -58.432292), -- 143,
(0, -34.555437, -58.371367), -- 144,
(0, -34.575664, -58.489801), -- 145,
(0, -34.619995, -58.400937), -- 146,
(0, -34.57967, -58.528766), -- 147,
(0, -34.567058, -58.500856), -- 148,
(0, -34.616147, -58.434651), -- 149,
(0, -34.561108, -58.49132) -- 150;
GO




-----------------------------------------STORED PROCEDURES---------------------------------------------------
CREATE PROCEDURE SP_Registrarse
    @Nombre VARCHAR(255),
    @Apellido VARCHAR(255),
    @Email VARCHAR(255),
    @Contrasena VARCHAR(255),
    @Patente VARCHAR(50),
    @IdMarca INT,
    @IdModelo INT
AS
BEGIN
    -- Declarar variable para el ID del usuario
    DECLARE @IdUsuario INT;

    -- Insertar en la tabla Usuario
    INSERT INTO [dbo].[Usuario] (nombre, apellido, email, contrasena)
    VALUES (@Nombre, @Apellido, @Email, @Contrasena);

    -- Obtener el ID del último registro insertado
    SET @IdUsuario = SCOPE_IDENTITY();

    -- Insertar en la tabla Auto, asociando con el usuario
    INSERT INTO [dbo].[Auto] (id_usuario, patente, id_marca, id_modelo)
    VALUES (@IdUsuario, @Patente, @IdMarca, @IdModelo);
END;
GO

CREATE PROCEDURE SP_IniciarSesion
@Email VARCHAR(255),
@Contrasena VARCHAR(255)
AS
BEGIN
SELECT Usuario.*
FROM Usuario
WHERE email = @Email AND contrasena = @Contrasena;
END;


CREATE PROCEDURE SP_OcuparEspacioEstacionamiento
    @UbicacionY FLOAT,
    @UbicacionX FLOAT,
    @Calle VARCHAR(100),
    @Altura VARCHAR(20),
    @IdUsuario INT
AS
BEGIN
    DECLARE @IdAuto INT;
    SELECT TOP 1 @IdAuto = id_auto FROM Auto WHERE id_usuario = @IdUsuario;

    IF NOT EXISTS (SELECT TOP 1 * FROM Estacionamiento WHERE id_auto = @IdAuto)
    BEGIN
        -- Verificar si existe un espacio en la ubicación especificada en la tabla Estacionamiento
        IF EXISTS (SELECT * FROM Estacionamiento WHERE ubicacionY = @UbicacionY AND ubicacionX = @UbicacionX)
        BEGIN
            -- Actualizar el espacio de estacionamiento si ya está ocupado
            UPDATE Estacionamiento
            SET 
                ocupado = 1,
                calle = @Calle, 
                altura_calle = @Altura, 
                fecha_ocupado = GETDATE(),
                id_auto = @IdAuto
            WHERE ubicacionY = @UbicacionY AND ubicacionX = @UbicacionX;
        END
        ELSE
        BEGIN
            -- Insertar un nuevo espacio de estacionamiento en la ubicación especificada
            INSERT INTO Estacionamiento (ocupado, calle, altura_calle, fecha_ocupado, id_auto, ubicacionY, ubicacionX)
            VALUES (1, @Calle, @Altura, GETDATE(), @IdAuto, @UbicacionY, @UbicacionX);
        END
    END
END;
