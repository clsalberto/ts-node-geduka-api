export interface Error {
  name: string
  message: string
  statusCode: number
}

export class ErrorBase implements Error {
  name: string
  message: string
  statusCode: number

  constructor(message: string, statusCode: number) {
    this.name = 'Error'
    this.message = message
    this.statusCode = statusCode
  }
}

export class BadRequestError extends ErrorBase {
  constructor(message: string) {
    super(message, 400)
    this.name = 'BadRequestError'
  }
}

export class NotFoundError extends ErrorBase {
  constructor(message: string) {
    super(message, 404)
    this.name = 'NotFoundError'
  }
}

export class UnauthorizedError extends ErrorBase {
  constructor(message: string) {
    super(message, 401)
    this.name = 'UnauthorizedError'
  }
}
