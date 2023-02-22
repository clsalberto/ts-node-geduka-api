import { randomUUID } from 'node:crypto'

export abstract class Entity<P> {
  protected _id: string
  public props: P

  constructor(props: P, id?: string) {
    this._id = id ?? randomUUID()
    this.props = props
  }

  get id(): string {
    return this._id
  }
}
