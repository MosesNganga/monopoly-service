/**
 * Type definitions for the Monopoly service
 *
 * @author: kvlinden
 * @date: Fall, 2025
 */

export interface Player {
    id: number;
    email: string;
    name: string;
}

export interface PlayerInput {
    email: string;
    name: string;
}

export type Game = {
  id: number;
  time: string;   // timestamp as ISO string
  status: string;
};

export type GamePlayer = {
  gameid: number;
  time: string;
  playerid: number;
  name: string;
  score: number;
};