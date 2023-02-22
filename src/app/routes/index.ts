import { Router } from 'express'

export const routes = Router()

routes.get('/', (_request, response) => {
  const message = {
    statusCode: 200,
    message: 'Bem-vindo ao Geduka!',
  }
  response.status(message.statusCode).json(message)
})
