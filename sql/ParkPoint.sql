CREATE DATABASE [ParkPoint]
GO

USE [ParkPoint]
GO


-- Tabla Ubicacion
CREATE TABLE [dbo].[Ubicacion](
    [id_ubicacion] INT IDENTITY(1,1) PRIMARY KEY,
    [ubicacionX] FLOAT NOT NULL,
    [ubicacionY] FLOAT NOT NULL
);
GO

-- Tabla Usuario
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
    [foto_usuario] VARCHAR(255) NULL
);
GO

-- Tabla Marca
CREATE TABLE [dbo].[Marca](
    [id_marca] INT IDENTITY(1,1) PRIMARY KEY,
    [nombre_marca] VARCHAR(255) NOT NULL
);
GO

-- Tabla Modelo
CREATE TABLE [dbo].[Modelo](
    [id_modelo] INT IDENTITY(1,1) PRIMARY KEY,
    [nombre_modelo] VARCHAR(255) NOT NULL,
    [id_marca] INT NOT NULL,
    FOREIGN KEY ([id_marca]) REFERENCES [dbo].[Marca]([id_marca])
);
GO

-- Tabla Auto
CREATE TABLE [dbo].[Auto](
    [id_auto] INT IDENTITY(1,1) PRIMARY KEY,
    [patente] VARCHAR(50) NOT NULL UNIQUE,
    [id_usuario] INT NOT NULL,
    [id_marca] INT NOT NULL,
    [id_modelo] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_modelo]) REFERENCES [dbo].[Modelo]([id_modelo])
);
GO

-- Tabla Puntos
CREATE TABLE [dbo].[Puntos](
    [id_puntos] INT IDENTITY(1,1) PRIMARY KEY,
    [cantidad] TEXT NOT NULL,
    [fecha_actualizacion] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

-- Tabla Canjeo
CREATE TABLE [dbo].[Canjeo](
    [id_canjeo] INT IDENTITY(1,1) PRIMARY KEY,
    [fecha_canjeo] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    [id_puntos] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_puntos]) REFERENCES [dbo].[Puntos]([id_puntos])
);
GO

-- Tabla Estacionamiento
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
    [id_usuario] INT NOT NULL,
    [id_ubicacion] INT NOT NULL,
    FOREIGN KEY ([id_auto]) REFERENCES [dbo].[Auto]([id_auto]),
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_ubicacion]) REFERENCES [dbo].[Ubicacion]([id_ubicacion])
);
GO

-- Tabla Infraccion
CREATE TABLE [dbo].[Infraccion](
    [id_motivo_infraccion] INT IDENTITY(1,1) PRIMARY KEY,
    [descripcion] VARCHAR(255) NULL
);
GO

-- Tabla Notificacion
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

-- Tabla Recompensa
CREATE TABLE [dbo].[Recompensa](
    [id_recompensa] INT IDENTITY(1,1) PRIMARY KEY,
    [titulo] TEXT NOT NULL,
    [descripcion] TEXT NOT NULL,
    [puntos_necesarios] INT NOT NULL,
    [imagen] VARCHAR(255) NULL,
    [id_canjeo] INT NOT NULL,
    FOREIGN KEY ([id_canjeo]) REFERENCES [dbo].[Canjeo]([id_canjeo])
);
GO

-- Tabla Registro
CREATE TABLE [dbo].[Registro](
    [id_registro] INT IDENTITY(1,1) PRIMARY KEY,
    [registro_aprobado] BIT NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

-- Tabla Reporte
CREATE TABLE [dbo].[Reporte](
    [id_reporte] INT IDENTITY(1,1) PRIMARY KEY,
    [fecha_reporte] DATE NOT NULL,
    [calle_infraccion] VARCHAR(255) NULL,
    [altura_infraccion] VARCHAR(255) NULL,
    [patente_reportada] VARCHAR(50) NOT NULL,
    [id_motivo_infraccion] INT NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_motivo_infraccion]) REFERENCES [dbo].[Infraccion]([id_motivo_infraccion]),
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO