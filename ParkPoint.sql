CREATE DATABASE [ParkPoint];
GO

USE [ParkPoint];
GO

CREATE TABLE [dbo].[Usuario](
    [id_usuario] INT IDENTITY(1,1) PRIMARY KEY,
    [dni] INT NOT NULL,
    [foto_dni] VARCHAR(255) NOT NULL,
    [nombre] VARCHAR(255) NOT NULL,
    [apellido] VARCHAR(255) NOT NULL,
    [email] VARCHAR(255) NOT NULL,
    [contrasena] VARCHAR(255) NOT NULL,
    [fecha_registro] TIME(7) NOT NULL,
    [foto_usuario] VARCHAR(255) NOT NULL
);
GO

CREATE TABLE [dbo].[Auto](
    [id_auto] INT IDENTITY(1,1) PRIMARY KEY,
    [patente] VARCHAR(50) NOT NULL,
    [marca] VARCHAR(255) NOT NULL,
    [modelo] VARCHAR(255) NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
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
    [ubicacion] GEOMETRY NOT NULL,
    [tiempo_promedio_llegada] TIME(7) NOT NULL,
    [id_auto] INT NOT NULL,
    FOREIGN KEY ([id_auto]) REFERENCES [dbo].[Auto]([id_auto])
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
    [puntos_necesarias] INT NOT NULL,
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

CREATE TABLE [dbo].[Reporte](
    [id_reporte] INT IDENTITY(1,1) PRIMARY KEY,
    [enTiempoRealOInfraccion] BIT NOT NULL,
    [Motivo_tiempo_real] VARCHAR(255) NOT NULL,
    [Motivo_infraccion] VARCHAR(255) NOT NULL,
    [calle_infraccion] VARCHAR(255) NOT NULL,
    [altura_infraccion] VARCHAR(255) NOT NULL,
    [patente_reportada] VARCHAR(255) NOT NULL,
    [fecha_reporte] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO
