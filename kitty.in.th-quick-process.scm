;; kitty.in.th-quick-process.scm
;; v. 0.05
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2006-2008 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script is a quick post-processing for kitty.in.th gallery
;;
;; ChangeLogs
;; v0.05 - Mon, 15 Dec 2008 22:40:12 +0700
;; - Move to Filters menu
;;
;; v0.04 Mon, 15 Dec 2008 14:47:08 +0700
;; - Use Luko's sharpening (required kitty.in.th-luko-sharpening.scm"
;;
;; v 0.03 Sat, 24 May 2008 02:11:28 +0700
;;   - Also perform aut HSV stretch
;;   - Scale to 640x424 instead of 544x361
;;
;; v!0.04 Mon, 15 Jun 2009 19:04:19 +0700
;;   - Update to Luko's Sharpening 0.03

(define (kitty.in.th-quick-process image drawable)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image))))
										
		(gimp-image-undo-group-start image)

		(if (< image-width image-height)
			(gimp-image-scale image 361 544)
			(gimp-image-scale image 544 361))
;			(gimp-image-scale image 424 640)
;			(gimp-image-scale image 640 424))
			
;		(plug-in-autostretch-hsv 1 image drawable)
;		(plug-in-unsharp-mask 1 image drawable 2.0 0.15 35)
		(kitty.in.th-luko-sharpen image drawable 50 20 20)
		(gimp-curves-spline drawable 0 8 (vector 0 0 64 60 192 196 255 255))
		(gimp-image-undo-group-end image)
		(gimp-displays-flush)))

(script-fu-register
	"kitty.in.th-quick-process"
	"<Image>/Filters/kitty.in.th/Quick Processing"
	"kitty.in.th Quick Processing v.0.05"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0)
