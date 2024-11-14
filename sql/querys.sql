INSERT INTO [dbo].[Infraccion] (descripcion)
VALUES 
    ('Mal estacionado'),
    ('Puesto prohibido/reservado'),
    ('Estacionamiento mal indicado');
GO

INSERT INTO [dbo].[Estacionamiento] (ocupado, ubicacionX, ubicacionY) 
VALUES 
    (1, -34.6064, -58.4116), -- 1
    (1, -34.6053, -58.4109), -- 2
    (1, -34.6078, -58.4155), -- 3
    (1, -34.6090, -58.4170), -- 4
    (1, -34.6080, -58.4182), -- 5
    (1, -34.6102, -58.4201), -- 6
    (1, -34.6110, -58.4233), -- 7
    (1, -34.6021, -58.4083), -- 8
    (1, -34.6034, -58.4065), -- 9
    (1, -34.6041, -58.4140), -- 10
    (1, -34.6018, -58.4051), -- 11
    (1, -34.6108, -58.4227), -- 12
    (1, -34.6073, -58.4199), -- 13
    (1, -34.6069, -58.4178), -- 14
    (1, -34.6050, -58.4132), -- 15
    (1, -34.6084, -58.4136), -- 16
    (1, -34.6095, -58.4112), -- 17
    (1, -34.6023, -58.4092), -- 18
    (1, -34.6038, -58.4075), -- 19
    (1, -34.6123, -58.4194), -- 20
    (1, -34.6132, -58.4209), -- 21
    (1, -34.6104, -58.4148), -- 22
    (1, -34.6045, -58.4165), -- 23
    (1, -34.6012, -58.4107), -- 24
    (1, -34.6076, -58.4138), -- 25
    (1, -34.6093, -58.4129), -- 26
    (1, -34.6120, -58.4215), -- 27
    (1, -34.6130, -58.4176), -- 28
    (1, -34.6042, -58.4197), -- 29
    (1, -34.6061, -58.4152), -- 30
    (1, -34.6106, -58.4089), -- 31
    (1, -34.6082, -58.4141), -- 32
    (1, -34.6059, -58.4170), -- 33
    (1, -34.6079, -58.4114), -- 34
    (1, -34.6127, -58.4183), -- 35
    (1, -34.6049, -58.4204), -- 36
    (1, -34.6091, -58.4160), -- 37
    (1, -34.6035, -58.4110), -- 38
    (1, -34.6124, -58.4221), -- 39
    (1, -34.6013, -58.4159), -- 40
    (1, -34.6072, -58.4135), -- 41
    (1, -34.6100, -58.4192), -- 42
    (1, -34.6099, -58.4078), -- 43
    (1, -34.6020, -58.4145), -- 44
    (1, -34.6117, -58.4133), -- 45
    (1, -34.6088, -58.4202), -- 46
    (1, -34.6031, -58.4127), -- 47
    (1, -34.6057, -58.4156), -- 48
    (1, -34.6107, -58.4204), -- 49
    (1, -34.6113, -58.4174); -- 50
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


-----------------------------------------STORED PROCEDURES---------------------------------------------------
CREATE PROCEDURE SP_Registrarse
    @DNI INT,
    @FotoDNI VARCHAR(255),
    @Nombre VARCHAR(255),
    @Apellido VARCHAR(255),
    @Email VARCHAR(255),
    @Contrasena VARCHAR(255),
    @IdMarca INT,
    @IdModelo INT
AS
BEGIN
    -- DECLARE @Edad INT;
    -- DECLARE @AñoActual DATE = GETDATE();


    -- -- Validación de DNI: No debe tener más de 8 dígitos
    -- IF LEN(CAST(@DNI AS VARCHAR(10))) > 8
    -- BEGIN
    --     RAISERROR('El DNI no puede tener más de 8 dígitos.', 16);
    --     RETURN;
    -- END;

    -- -- Validación de Fecha de Vencimiento del Carnet: No puede ser una fecha pasada
    -- IF @FechaVencimientoCarnet < CONVERT(TIME, GETDATE())
    -- BEGIN
    --     RAISERROR('La fecha de vencimiento del carnet no puede ser una fecha pasada.', 16);
    --     RETURN;
    -- END;

    -- -- Validación de Edad: Debe ser igual o mayor a 17 años
    -- SET @Edad = DATEDIFF(YEAR, @FechaNacimiento, @AñoActual);
    -- IF (MONTH(@FechaNacimiento) > MONTH(@AñoActual) OR
    --    (MONTH(@FechaNacimiento) = MONTH(@AñoActual) AND DAY(@FechaNacimiento) > DAY(@AñoActual)))
    -- BEGIN
    --     SET @Edad = @Edad - 1;
    -- END;

    -- IF @Edad < 17
    -- BEGIN
    --     RAISERROR('La edad debe ser igual o mayor a 17 años.', 16);
    --     RETURN;
    -- END;



    -- Si todas las validaciones son exitosas, inserta el nuevo usuario en la tabla Usuario
INSERT INTO [dbo].[Usuario] (dni, foto_dni, nombre, apellido, email, contrasena, fecha_registro)
VALUES (@DNI, @FotoDNI, @Nombre, @Apellido, @Email, @Contrasena, CONVERT(TIME, GETDATE()));
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
GO

CREATE PROCEDURE SP_OcuparEspacioEstacionamiento
    @UbicacionX FLOAT,
    @UbicacionY FLOAT,
    @Calle VARCHAR(100),
    @Altura VARCHAR(20),
    @IdAuto INT,
    @IdUsuario INT
AS
BEGIN
    -- Verificar si existe un espacio en la ubicación especificada en la tabla Estacionamiento
    IF NOT EXISTS (
        SELECT 1 
        FROM Estacionamiento 
        INNER JOIN Ubicacion 
        ON Estacionamiento.id_ubicacion = Ubicacion.id_ubicacion
        WHERE Ubicacion.ubicacionX = @UbicacionX AND Ubicacion.ubicacionY = @UbicacionY
    )
    BEGIN
        -- Insertar un nuevo registro en la tabla Ubicacion si la ubicación no existe
        DECLARE @IdUbicacion INT;
        INSERT INTO Ubicacion (ubicacionX, ubicacionY)
        VALUES (@UbicacionX, @UbicacionY);

        SET @IdUbicacion = SCOPE_IDENTITY();

        -- Insertar un nuevo espacio de estacionamiento en la ubicación especificada
        INSERT INTO Estacionamiento (ocupado, calle, altura_calle, fecha_ocupado, id_auto, id_usuario, id_ubicacion)
        VALUES (1, @Calle, @Altura, GETDATE(), @IdAuto, @IdUsuario, @IdUbicacion);
    END
    ELSE
    BEGIN
        -- Actualizar el espacio de estacionamiento existente para marcarlo como ocupado y actualizar la información
        UPDATE Estacionamiento 
        SET ocupado = 1, 
            calle = @Calle, 
            altura_calle = @Altura, 
            fecha_ocupado = GETDATE(),
            id_auto = @IdAuto,
            id_usuario = @IdUsuario
        WHERE id_ubicacion = (
            SELECT id_ubicacion 
            FROM Ubicacion 
            WHERE ubicacionX = @UbicacionX AND ubicacionY = @UbicacionY
        );
    END;
END;
GO