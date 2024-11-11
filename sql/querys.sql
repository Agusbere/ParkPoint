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