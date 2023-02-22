import { HttpResponse } from './response'

export abstract class UseCase<R, S> {
  abstract execute(request?: R): Promise<HttpResponse<S>>
}
