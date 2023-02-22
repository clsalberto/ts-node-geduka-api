export interface HttpResponse<T> {
  message: string
  statusCode: number
  data?: T
}
