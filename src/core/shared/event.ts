import { EventEmitter } from 'node:events'

export abstract class Event<T> {
  private emitter = new EventEmitter()

  constructor(name: string) {
    this.emitter.on(name, this.process.bind(this))
  }

  public emit(name: string, data: T): void {
    this.emitter.emit(name, data)
  }

  abstract process(data: T): void
}
