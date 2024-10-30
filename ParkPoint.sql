CREATE DATABASE [ParkPoint];
GO

USE [ParkPoint];
GO

-------------------------------------------TABLAS------------------------------------------------------------
CREATE TABLE [dbo].[Genero](
    [id_genero] INT IDENTITY(1,1) PRIMARY KEY,
    [nombre_genero] VARCHAR(255) NOT NULL
);
GO

CREATE TABLE [dbo].[Ubicacion](
    [id_ubicacion] INT IDENTITY(1,1) PRIMARY KEY,
    [ubicacionX] FLOAT NOT NULL,
    [ubicacionY] FLOAT NOT NULL
);
GO

CREATE TABLE [dbo].[Usuario](
    [id_usuario] INT IDENTITY(1,1) PRIMARY KEY,
    [dni] INT NOT NULL,
    [foto_dni] VARCHAR(255) NOT NULL,
    [nombre] VARCHAR(255) NOT NULL,
    [apellido] VARCHAR(255) NOT NULL,
    [fecha_nacimiento] DATE NOT NULL,
    [email] VARCHAR(255) NOT NULL,
    [contrasena] VARCHAR(255) NOT NULL,
    [fecha_registro] DATE NOT NULL,
    [fecha_vencimiento_carnet] DATE NOT NULL,
    [foto_carnet] VARCHAR(255) NOT NULL,
    [foto_usuario] VARCHAR(255) NOT NULL,
    [id_genero] INT NOT NULL,
    [id_ubicacion] INT NOT NULL
    FOREIGN KEY ([id_ubicacion]) REFERENCES [dbo].[Ubicacion]([id_ubicacion]),
    FOREIGN KEY ([id_genero]) REFERENCES [dbo].[Genero]([id_genero])
);
GO

CREATE TABLE [dbo].[Marca](
    [id_marca] INT IDENTITY(1,1) PRIMARY KEY,
    [nombre_marca] VARCHAR(255) NOT NULL
);
GO

CREATE TABLE [dbo].[Modelo](
    [id_modelo] INT IDENTITY(1,1) PRIMARY KEY,
    [nombre_modelo] VARCHAR(255) NOT NULL,
    [id_marca] INT NOT NULL
    FOREIGN KEY ([id_marca]) REFERENCES [dbo].[Marca]([id_marca])
);
GO

CREATE TABLE [dbo].[Auto](
    [id_auto] INT IDENTITY(1,1) PRIMARY KEY,
    [patente] VARCHAR(50) NOT NULL,
    [id_usuario] INT NOT NULL,
    [id_marca] INT NOT NULL,
    [id_modelo] INT NOT NULL
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_marca]) REFERENCES [dbo].[Marca]([id_marca]),
    FOREIGN KEY ([id_modelo]) REFERENCES [dbo].[Modelo]([id_modelo])
);
GO

CREATE TABLE [dbo].[Estacionamiento](
    [id_estacionamiento] INT IDENTITY(1,1) PRIMARY KEY,
    [sePuedeEstacionar] BIT NOT NULL,
    [ocupado] BIT NOT NULL,
    [calle] TEXT NOT NULL,
    [altura_calle] TEXT NOT NULL,
    [fecha_libre] DATE NOT NULL,
    [fecha_ocupado] DATE NOT NULL,
    [tiempo_estacionado] TIME(7) NOT NULL,
    [tiempo_promedio_llegada] TIME(7) NOT NULL,
    [id_auto] INT NOT NULL,
    [id_usuario] INT NOT NULL
    [id_ubicacion] INT NOT NULL
    FOREIGN KEY ([id_ubicacion]) REFERENCES [dbo].[Usuario]([id_ubicacion]),
    FOREIGN KEY ([id_auto]) REFERENCES [dbo].[Auto]([id_auto]),
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

CREATE TABLE [dbo].[Puntos](
    [id_puntos] INT IDENTITY(1,1) PRIMARY KEY,
    [cantidad] TEXT NOT NULL,
    [fecha_actualizacion] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

CREATE TABLE [dbo].[Canjeo](
    [id_canjeo] INT IDENTITY(1,1) PRIMARY KEY,
    [fecha_canjeo] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    [id_puntos] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_puntos]) REFERENCES [dbo].[Puntos]([id_puntos])
);
GO

CREATE TABLE [dbo].[Recompensa](
    [id_recompensa] INT IDENTITY(1,1) PRIMARY KEY,
    [titulo] TEXT NOT NULL,
    [descripcion] TEXT NOT NULL,
    [puntos_necesarios] INT NOT NULL,
    [imagen] VARCHAR(255) NOT NULL,
    [id_canjeo] INT NOT NULL,
    FOREIGN KEY ([id_canjeo]) REFERENCES [dbo].[Canjeo]([id_canjeo])
);
GO

CREATE TABLE [dbo].[Notificacion](
    [id_notificacion] INT IDENTITY(1,1) PRIMARY KEY,
    [titulo] TEXT NOT NULL,
    [descripcion] TEXT NOT NULL,
    [fecha_notificacion] DATE NOT NULL,
    [leido] BIT NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

CREATE TABLE [dbo].[Registro](
    [id_registro] INT IDENTITY(1,1) PRIMARY KEY,
    [registro_aprobado] BIT NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO


CREATE TABLE [dbo].[Tiempo_Real](
    [id_reporte_tiempo_real] INT IDENTITY(1,1) PRIMARY KEY,
    [descripcion] VARCHAR(255) NULL,
    [id_ubicacion] INT NOT NULL,
    FOREIGN KEY ([id_ubicacion]) REFERENCES [dbo].[UbicacionReporteTiempoReal]([id_ubicacion])
);
GO

CREATE TABLE [dbo].[Infraccion](
    [id_reporte_infraccion] INT IDENTITY(1,1) PRIMARY KEY,
    [descripcion] VARCHAR(255) NULL,
    [calle_infraccion] VARCHAR(255) NULL,
    [altura_infraccion] VARCHAR(255) NULL,
    [patente_reportada] VARCHAR(255) NULL
    --CONECTAR LA PATENTE QUE REPORTAS CON LA PATENTE DE UN AUTO Y EL ID DE USUARIO (TABLA DE AUTO) CON EL ID DE USUARIO (TABLA DE USUARIOS)
);
GO

CREATE TABLE [dbo].[Reporte](
    [id_reporte] INT IDENTITY(1,1) PRIMARY KEY,
    [enTiempoRealOInfraccion] BIT NOT NULL,
    [fecha_reporte] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    [id_reporte_tiempo_real] INT NOT NULL,
    [id_reporte_infraccion] INT NOT NULL
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_reporte_tiempo_real]) REFERENCES [dbo].[Tiempo_Real]([id_reporte_tiempo_real]),
    FOREIGN KEY ([id_reporte_infraccion]) REFERENCES [dbo].[Infraccion]([id_reporte_infraccion])
);
GO
---------------------------------------------INSERTS--------------------------------------------------------
INSERT INTO [dbo].[Genero] (nombre_genero)
VALUES ('Masculino'), ('Femenino'), ('No binario');
GO

--Agregar insert de tiempo real
--Agregar insert de infraccion 

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
    @FechaNacimiento DATE,
    @FechaVencimientoCarnet TIME(7),
    @FotoCarnet VARCHAR(255),
    @FotoUsuario VARCHAR(255),
    @IdGenero INT
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
    INSERT INTO [dbo].[Usuario] (dni, foto_dni, nombre, apellido, email, contrasena, fecha_registro, 
    fecha_vencimiento_carnet, foto_carnet, fecha_nacimiento, id_genero, foto_usuario)
    VALUES (@DNI, @FotoDNI, @Nombre, @Apellido, @Email, @Contrasena, CONVERT(TIME, GETDATE()), 
            @FechaVencimientoCarnet, @FotoCarnet, @FechaNacimiento, @IdGenero, @FotoUsuario);
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

